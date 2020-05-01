extends ColorRect

const slot = preload("res://Scenes/Slot.tscn")
const inventory_item = preload("res://Scripts/InventoryItem.gd")

export var row = 6
export var column = 8
export var marginLeft = 10

func _ready():
	self.visible = false
	var pos = Vector2(0, 50)
	for r in range(row):
		pos.x = marginLeft
		for c in range(column):
			var item = slot.instance()
			item.rect_position = Vector2(pos.x, pos.y)
			var slotimage = item.get_node("SlotImage")
			slotimage.texture = null
			self.add_child(item)
			pos.x += 60
			InventoryUi.slots.append(item)
		pos.y += 60
