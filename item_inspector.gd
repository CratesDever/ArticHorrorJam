extends Control
@export var yesButton : Control
@export var noButton : Control
@export var selector : Control
var selected : bool = false
var isOpen = false
func _ready() -> void:
	if selected:
		selector.position = noButton.position
	else:
		selector.position = yesButton.position
func _input(event: InputEvent) -> void:
	if isOpen:
		if Input.is_action_just_pressed("D"):
			selected = !selected
		if Input.is_action_just_pressed("A"):
			selected = !selected
		
		if selected:
			selector.position = noButton.position
		else:
			selector.position = yesButton.position
func SetOpen(isTrue):
	isOpen = isTrue
		
