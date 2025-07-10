extends Control

@export var selector : Control

@export var inventoryVisualsList : Array[Node]
var selectNum : int = 0

func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("W"):
		if selectNum > 3:
			selectNum-= 4
		updateSelector()
		
	if Input.is_action_just_pressed("S"):
		if selectNum <= 3:
			selectNum+= 4
		
		updateSelector()
	if Input.is_action_just_pressed("A"):
		if selectNum > 0:
			selectNum-=1
		else:
			selectNum = inventoryVisualsList.size()-1
		updateSelector()
		
	if Input.is_action_just_pressed("D"):
		if selectNum < inventoryVisualsList.size()-1:
			selectNum+=1
		else:
			selectNum = 0
		updateSelector()
			
func updateSelector():
	selector.position = inventoryVisualsList[selectNum].position
	
		
