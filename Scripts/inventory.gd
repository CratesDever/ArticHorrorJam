extends Control

@export var selector : Control
@export var emptySlotImage : Texture
@export var inventoryVisualsList : Array[Node]
@export var items : Array[inv_item]
@export var equippedSlot : Node
var equippedItem : inv_item
var selectNum : int = 0
var isOpen = false
#equip menu
var equipisOpen = false
@export var equipMenu : Control
@export var equipSelector : Control
@export var equipVisualsList : Array[Node]
@export var player : Player
@export var itemPrefab : PackedScene
var equipSelectNum = 0

func _input(event: InputEvent) -> void:
	if isOpen:
		if Input.is_action_just_pressed("W") and !equipisOpen:
			if selectNum > 3:
				selectNum-= 4
			updateSelector()
			
		if Input.is_action_just_pressed("S") and !equipisOpen:
			if selectNum <= 3:
				selectNum+= 4
			
			updateSelector()
		if Input.is_action_just_pressed("A") and !equipisOpen:
			if selectNum > 0:
				selectNum-=1
			else:
				selectNum = inventoryVisualsList.size()-1
			updateSelector()
		
		if Input.is_action_just_pressed("D")  and !equipisOpen:
			if selectNum < inventoryVisualsList.size()-1:
				selectNum+=1
			else:
				selectNum = 0
			updateSelector()
		if Input.is_action_just_pressed("W") and equipisOpen:
			if equipSelectNum > 0:
				equipSelectNum -= 1
				equipSelector.position = equipVisualsList[equipSelectNum].position
			
		if Input.is_action_just_pressed("S") and equipisOpen:
			if equipSelectNum < 2:
				equipSelectNum += 1
				equipSelector.position = equipVisualsList[equipSelectNum].position
		if Input.is_action_just_pressed("SPACE") and items.size() > selectNum and !equipisOpen:
			EquipOpen(true)
			
		elif Input.is_action_just_pressed("SPACE") and equipisOpen:
			if equipSelectNum == 0:
				
				var copy = null	
				if equippedItem != null:
					copy = equippedItem
				equippedItem = items[selectNum]
				equippedSlot.texture = equippedItem.image
				
				if copy != null:
					items[selectNum] = copy
				else:
					items.remove_at(selectNum)
				inventoryVisualsList[selectNum].texture = emptySlotImage 
				for a in inventoryVisualsList:
					a.texture = emptySlotImage
				for i in items.size():
					if i < items.size() and items[i] != null:
						inventoryVisualsList[i].texture = items[i].image
					else:
						inventoryVisualsList[i].texture = emptySlotImage
				CheckEquipWeapon()
			if equipSelectNum == 1:
				var itmObj = itemPrefab.instantiate()
				itmObj.position = player.global_position
				itmObj.SetChildItem(items[selectNum])
				get_tree().root.add_child(itmObj)
				items.remove_at(selectNum)
				inventoryVisualsList[selectNum].texture = emptySlotImage 
				for a in inventoryVisualsList:
					a.texture = emptySlotImage
				for i in items.size():
					if i < items.size() and items[i] != null:
						inventoryVisualsList[i].texture = items[i].image
					else:
						inventoryVisualsList[i].texture = emptySlotImage
				
			if equipSelectNum == 2:
				pass
			EquipOpen(false)
		
func Open(isTrue):
	selectNum = 0
	isOpen = isTrue		
	selector.position = inventoryVisualsList[selectNum].position
	
func updateSelector():
	selector.position = inventoryVisualsList[selectNum].position
	
func AddItem(item):
	items.append(item)
	for i in items.size():
		if i < items.size() and items[i] != null:
			inventoryVisualsList[i].texture = items[i].image
		else:
			inventoryVisualsList[i].texture = emptySlotImage
func EquipOpen(isTrue):
	if isTrue:
		equipSelectNum = 0
		equipSelector.position = equipVisualsList[equipSelectNum].position
		equipMenu.position = inventoryVisualsList[selectNum].position
		equipisOpen = true
		equipMenu.show()
	else:
		equipMenu.hide()
		equipisOpen = false
		
func CheckEquipWeapon():
	if equippedItem.isGun:
		player.SetGun(true)
	else:
		player.SetGun(false)
		
func GetInventory() -> Array[inv_item]:
	return items
func GetEquipped() -> inv_item:
	return equippedItem
func LoadItems(loaded,equipLoad):
	items.clear()
	items = loaded
	equippedItem = equipLoad
	if equippedItem != null:
		equippedSlot.texture = equippedItem.image
	else:
		equippedSlot.texture = emptySlotImage
	for a in inventoryVisualsList.size():
		inventoryVisualsList[a].texture = emptySlotImage	
	for i in items.size():
		if i < items.size() and items[i] != null:
			inventoryVisualsList[i].texture = items[i].image
		else:
			inventoryVisualsList[i].texture = emptySlotImage	
