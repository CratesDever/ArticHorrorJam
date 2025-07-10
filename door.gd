extends Node3D


@export var camera : Camera3D




func _on_trigger_body_entered(body: Node3D) -> void:
	if body is Player:
		camera.current = true
