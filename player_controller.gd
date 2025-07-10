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

var isAiming : bool = false 
var isTurning = false
var current_yaw
var target_yaw
var isOpenInventory = false
var currentBody : Node3D

func _ready() -> void:
	verify_save_directory(save_file_path)
	
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
func load_data():
	playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	self.position = playerData.SavedPosition
	print("Loaded")
func save():
	playerData.update_position(self.position)
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("save")
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("SAVE"):
		save()
	if Input.is_action_pressed("LOAD"):
		load_data()
	if Input.is_action_pressed("shift"):
		isAiming = true
	else:
		isAiming = false
	if Input.is_action_just_pressed("TAB"):
		isOpenInventory = !isOpenInventory
		if isOpenInventory:
			inventory.show()
		else:
			inventory.hide()
	if Input.is_action_just_pressed("SPACE") and currentBody != null:
		itemInspect.show()
		itemInspect.SetOpen(true)
	
		

func _physics_process(delta):
	if !isOpenInventory:
		if isTurning:
			print("Turning")
			rotation.y = lerp_angle(rotation.y, target_yaw, delta * 3.5)
			if abs(angle_difference(rotation.y, target_yaw)) < 0.1:
				rotation.y = target_yaw
				isTurning = false
		if !isTurning:
			var move_input = 0.0
			var turn_input = 0.0
			var aim_input = 0.0
			if !isAiming:
				if Input.is_action_pressed("W"):    # W
					move_input += 1.0
				if Input.is_action_just_pressed("S") and !isTurning:  
					current_yaw = rotation.y
					target_yaw = current_yaw + deg_to_rad(180)
					isTurning = true
				
			else:
				if Input.is_action_pressed("W"):    # W
					aim_input += 1.0
				if Input.is_action_pressed("S"):  # S
					aim_input -= 1.0
				aimTarget.rotate_x(aim_input * aim_rotation_speed * delta)
			if Input.is_action_pressed("D"): # D
				turn_input -= 1.0
			if Input.is_action_pressed("A"):  # A
					turn_input += 1.0
			if turn_input != 0:
				rotate_y(turn_input * rotation_speed * delta)
			var forward_dir := -transform.basis.z
			velocity = forward_dir * move_input * move_speed
		move_and_slide()
			



		


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is Item and currentBody == null:
		currentBody = area



func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is Item and currentBody != null:
		currentBody = null
