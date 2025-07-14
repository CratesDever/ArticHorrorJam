class_name Item
extends Area3D

@export var item : inv_item

func pickedup():
	$"..".queue_free()
func SetItem(itm):
	item = itm
