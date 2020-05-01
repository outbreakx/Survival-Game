extends Node

# remember this must be equal or lower than row * column from inventory.gd
# 8 is the size of holding items
export var max_inventory = 48
var max_holding_items = 8
var items = []


# Called when the node enters the scene tree for the first time.
func _ready():
	items.resize(max_inventory + max_holding_items)

func add_item(item, amount = 1):
	var first_empty = -1
	var id = -1

	# give priority to holding items slots.
	for i in range(max_holding_items):
		var index = max_inventory + i

		if first_empty != -1 and id != -1:
			break
		if first_empty == -1 and items[index] == null:
			first_empty = index
		elif items[index] != null and items[index].id == item.id:
			id = index
			break

	for index in range(max_inventory):
		if first_empty != -1 and id != -1:
			break
		if first_empty == -1 and items[index] == null:
			first_empty = index
		elif items[index] != null and items[index].id == item.id:
			id = index
			break
	
	if id != -1:
		items[id].amount += amount
	else:
		set_item(first_empty, item)

func set_item(index, item):
	if index >= 0 and index < max_inventory + max_holding_items:
		items[index] = item
func get_item(index):
	if index >= 0 and index < max_inventory + max_holding_items:
		return items[index]
	return null

func get_items():
	return items
