extends Area3D

@export var cutscene : Node3D
@export var enterDoorPosition : Node3D
var curBody

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		curBody = body
		cutscene.begincutscene(self)


func endcutscene():
	print("Called", curBody)
	if curBody:
		curBody.SetPlayerPosition(enterDoorPosition.global_position)
		curBody = null
		
		
		
