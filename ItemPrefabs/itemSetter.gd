extends RigidBody3D

@export var itemScript : Area3D
@export var startingItem : inv_item

func _ready() -> void:
	if startingItem != null:
		SetChildItem(startingItem)

func SetChildItem(itm):
	itemScript.SetItem(itm)
