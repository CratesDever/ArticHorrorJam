extends Node3D

@export var animationPlayer : AnimationPlayer
@export var thisCamera : Camera3D
var currentDoor
func _ready() -> void:
	pass
func begincutscene(door):
	animationPlayer.play("DoorEnter")
	thisCamera.current = true
	currentDoor = door

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("done", currentDoor)
	if currentDoor:
		currentDoor.endcutscene()
		currentDoor = null
