extends ColorRect


const slot = preload("res://Scenes/Slot.tscn")
const inventory_item = preload("res://Scripts/InventoryItem.gd")

export var column = 8
export var marginLeft = 2
export var backgroundColor = "#143e3e3e"

func _ready():
	var pos  = Vector2(marginLeft, 0)
	for i in range(column):
		var item = slot.instance()
		item.rect_position = Vector2(pos.x, pos.y)
		var slotimage = item.get_node("SlotImage")
		slotimage.texture = null
		var keyLabel = item.get_node("Key")
		var key = OS.get_scancode_string(InputMap.get_action_list("item_%s" % str(i + 1))[0].scancode)
		keyLabel.text = key
		pos.x += 50 + marginLeft		
		item.color = Color(backgroundColor)
		self.add_child(item)
		InventoryUi.slots.append(item)
