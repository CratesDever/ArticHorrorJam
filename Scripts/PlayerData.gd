extends Resource

class_name PlayerData

@export var speed = 5
@export var health = 100
@export var savedItems : Array[inv_item]
@export var savedEquip : inv_item
@export var SavedPosition : Vector3
func change_health(value : int):
	health += value
	
func update_position(pos : Vector3):
	SavedPosition = pos
	
func update_items(itms : Array[inv_item], equipItm : inv_item):
	savedItems = itms
	savedEquip = equipItm
	
