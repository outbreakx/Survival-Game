extends Node

export var spawn_range = 3

onready var camera = $"../Head/Camera"


func create_item():
	var item = ItemsData.items['ak47'].prefab_pickable.instance()
	var from = camera.project_ray_origin( get_viewport().get_mouse_position())
	var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * spawn_range
		
	item.get_node("RigidBody").transform.origin = to
	self.add_child(item)
