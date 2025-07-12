class_name Player

extends CharacterBody3D

var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()

@export var move_speed = 5.0
@export var rotation_speed = 2.0
@export var aim_rotation_speed = 2.0
@export var aimTarget : Node3D    
@export var inventory : Control
@export var itemInspect : Control
@export var bullet : PackedScene
@export var firePoint : Node3D
var isAiming : bool = false 
var isTurning = false
var current_yaw
var target_yaw
var isOpenInventory = false
var currentBody : Node3D
var canMove = true 
var inspectOpen = false
var hasGun : bool = false
func _ready() -> void:
	verify_save_directory(save_file_path)
	
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
func load_data():
	playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	self.position = playerData.SavedPosition
	inventory.LoadItems(playerData.savedItems, playerData.savedEquip)
	print("Loaded")
func save():
	playerData.update_position(self.position)
	playerData.update_items(inventory.GetInventory(), inventory.GetEquipped())
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("save")
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("SAVE"):
		save()
	if Input.is_action_pressed("LOAD"):
		load_data()
	if Input.is_action_pressed("CONTROL"):
		isAiming = true
	else:
		isAiming = false
	if Input.is_action_just_pressed("TAB") and !inspectOpen:
		isOpenInventory = !isOpenInventory
		inventory.Open(isOpenInventory)
		if isOpenInventory:
			inventory.show()
		else:
			inventory.hide()
	if Input.is_action_just_pressed("SPACE") and currentBody != null and !inspectOpen and !isAiming and !isOpenInventory:
		itemInspect.show()
		canMove = false
		itemInspect.SetOpen(true)
		inspectOpen = true
	
		

func _physics_process(delta):
	if !isOpenInventory and canMove:
		if !isAiming:
			if abs(angle_difference(aimTarget.rotation.x, 0)) > 0.05:
				aimTarget.rotation.x = lerp_angle(aimTarget.rotation.x, 0, delta * 3)
			
				
		if isTurning:
			rotation.y = lerp_angle(rotation.y, target_yaw, delta * 3.5)
			if abs(angle_difference(rotation.y, target_yaw)) < 0.1:
				rotation.y = target_yaw
				isTurning = false
		if !isTurning:
			var move_input = 0.0
			var turn_input = 0.0
			var aim_input = 0.0
			if !isAiming:
				if Input.is_action_pressed("W"):
					move_input += 1.0
				if Input.is_action_just_pressed("S") and Input.is_action_pressed("shift") and !isTurning:  
					current_yaw = rotation.y
					target_yaw = current_yaw + deg_to_rad(180)
					isTurning = true
				
				
			else:
				if Input.is_action_just_pressed("SPACE") and hasGun:
					var bul = bullet.instantiate()
					bul.position = firePoint.global_position
					bul.rotation = firePoint.global_rotation
					get_parent().get_parent().add_child(bul)
				if Input.is_action_pressed("W"):
					aim_input += 1.0
				if Input.is_action_pressed("S"):
					aim_input -= 1.0
				aimTarget.rotate_x(aim_input * aim_rotation_speed * delta)
			if Input.is_action_pressed("D"):
				turn_input -= 1.0
			if Input.is_action_pressed("A"):
					turn_input += 1.0
			if turn_input != 0:
				rotate_y(turn_input * rotation_speed * delta)
			var forward_dir := -transform.basis.z
			velocity = forward_dir * move_input * move_speed
			move_and_slide()
			



		
func itemPickedUp(isTrue):
	if !isTrue and currentBody:
		currentBody.pickedup()
		inventory.AddItem(currentBody.item)
		itemInspect.hide()
		currentBody = null
		
	else:
		itemInspect.hide()
	canMove = true
	inspectOpen = false
	

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is Item and currentBody == null:
		currentBody = area
		print("Entered", currentBody)



func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is Item and currentBody != null:
		currentBody = null
		
		print("Exited")
		
func SetGun(isTrue):
	print("Armed")
	hasGun = isTrue
