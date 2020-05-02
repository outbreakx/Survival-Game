extends Node

var holding_name = null
var slots = []

func _ready():
	clear_items()
	pass

func clear_items(): 
	for item in slots:
		if item != null:
			item.queue_free()
	slots = []

func update():
	var index = 0
	for item in InventoryManager.get_items():
		if item != null and slots[index]:
			slots[index].get_node("SlotImage/Count").text = str(item.amount)
			slots[index].get_node("SlotImage").texture = item.texture
		elif slots[index]:
			slots[index].get_node("SlotImage/Count").text = ""
			slots[index].get_node("SlotImage").texture = null
		index += 1
	
	# id fix for the holding items
	index = 48
	for i in range(8):
		slots[index + i].name = "@Slot@" + str(index + i)


func on_change_slot(old_slot, new_slot):
	var old_id = null
	var new_id = null
	for i in len(slots):
		if slots[i].name == old_slot:
			old_id = i
		elif slots[i].name == new_slot:
			new_id = i
		if old_id != null and new_id != null:
			break
	
	print("clicked in slots %s to %s" % [old_id, new_id])
	if old_id != null and new_id != null and slots[old_id].get_node("SlotImage").texture != null:
		print("changed slot %s to %s" % [old_id, new_id])
		"""
		var temp = slots[old_id].get_node("SlotImage").texture
		slots[old_id].get_node("SlotImage").texture = slots[new_id].get_node("SlotImage").texture
		slots[new_id].get_node("SlotImage").texture = temp
		"""

		var temp = InventoryManager.get_item(old_id)

		InventoryManager.set_item(old_id, InventoryManager.get_item(new_id))
		InventoryManager.set_item(new_id, temp)
	if old_id and slots[old_id].get_node("SlotImage").texture:
		slots[old_id].reset_image()
	update()

