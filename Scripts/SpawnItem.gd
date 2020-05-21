extends Node

export var spawn_range = 3

onready var camera = $"../Head/Camera"
onready var holding_item_manager = $"../HoldingItemManager"
onready var bullet = preload("res://Prefabs/Bullet.tscn")

func create_item():
	var item_in_slot = null
	if holding_item_manager.current_slot != null:
		item_in_slot = InventoryManager.get_item(holding_item_manager.current_slot)
	
	var item = null
	
	if item_in_slot != null:
		item = ItemsData.items[item_in_slot.item].prefab_pickable.instance()
	"""
	else:
		item = ItemsData.items['ak47'].prefab_pickable.instance()
	"""
	if item:
		item = bullet.instance()
		var from = camera.project_ray_origin( get_viewport().get_mouse_position())
		var init = from + camera.project_ray_normal(get_viewport().get_mouse_position())
		var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * spawn_range
		
		item.get_node("RigidBody").transform.origin = to
		self.add_child(item)

		item.get_node("RigidBody").apply_impulse(Vector3(0, 0, 0), Vector3(0, 0, -10))
