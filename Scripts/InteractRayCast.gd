extends RayCast

onready var pick = $"../../../Hud/Pick"


const inventory_item = preload("res://Scripts/InventoryItem.gd")

func _ready():
	#populate_inventory()
	pass

func _process(delta):
	check_collision()

func populate_inventory():
	var itemData = ItemsData.items["ak47"]
	var item = inventory_item.new(itemData, 1, "ak47")
	
	InventoryManager.set_item(48, item)

	itemData = ItemsData.items["glock45"]
	item = inventory_item.new(itemData, 1, "glock45")
	InventoryManager.set_item(49, item)

	
func check_collision():
	var collider = get_collider()
	if is_colliding() and collider is Interactable:
		if not pick.visible:
			set_interaction_text(collider.get_interaction_text())
			pick.visible = true
		if Input.is_action_pressed("interact"):
			var itemData = ItemsData.items[collider.item]

			var item = inventory_item.new(itemData, 1, collider.item)
			InventoryManager.add_item(item)
			InventoryUi.update()
			collider.get_parent().queue_free()
			pick.visible = false
	else:
		if pick.visible:
			pick.visible = false

func set_interaction_text(text):
	var interact_key = OS.get_scancode_string(InputMap.get_action_list('interact')[0].	scancode)
	pick.set_text("Press %s to %s" % [interact_key, text])
