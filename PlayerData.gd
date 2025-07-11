extends Resource

class_name PlayerData

@export var speed = 5
@export var health = 100

@export var SavedPosition : Vector3
func change_health(value : int):
	health += value
	
func update_position(pos : Vector3):
	SavedPosition = pos
