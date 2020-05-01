extends Node

onready var weapon = $"../Head/Camera/Weapon"


var starting_index = 48
var ending_index = 56
var last_state = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_holding()
	pass # Replace with function body.

func clear_holding():
	for item in weapon.get_children():
		for temp in item.get_children():
			temp.queue_free()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	for i in range(ending_index - starting_index):
		var item_index = starting_index + i
		if Input.is_action_just_pressed("item_%s" % str(i + 1)):
			# clear what the player is holding.
			clear_holding()
			var item = InventoryManager.get_item(item_index)
			if item != null:
				if item.type == "weapon":
					match(item.weapon_type):
						"HandGun":
							var instance = ItemsData.items[item.item].prefab.instance()
							weapon.get_node(item.weapon_type).add_child(instance)
							pass
						"Rifle":
							var instance = ItemsData.items[item.item].prefab.instance()
							weapon.get_node(item.weapon_type).add_child(instance)
							pass
				else:
					var instance = ItemsData.items[item.item].prefab.instance()
					weapon.get_node("Item").add_child(instance)
