extends Control
@export var yesButton : Control
@export var noButton : Control
@export var selector : Control
var selected : bool = false
var isOpen = false
@export var playerScript : Player

func _ready() -> void:
	pass
func _input(event: InputEvent) -> void:
	if isOpen:
		if Input.is_action_just_pressed("D"):
			selected = !selected
		if Input.is_action_just_pressed("A"):
			selected = !selected
		if Input.is_action_just_pressed("SPACE"):
			playerScript.itemPickedUp(selected)
			isOpen = false
		
		if selected:
			selector.global_position = noButton.global_position
		else:
			selector.global_position = yesButton.global_position
func SetOpen(isTrue):
	
	await get_tree().create_timer(0.1).timeout
	
	isOpen = isTrue
	
	
		
