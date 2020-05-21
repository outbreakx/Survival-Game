extends Node

var items = {}

"""
id
"""

func _ready():
	items["cube"] = {
		"id": 0,
		"type": "item",
		"prefab": preload("res://Prefabs/Cube.tscn"),
		"prefab_pickable": preload("res://Prefabs/PickableItems/Cube.tscn"),
		"texture": preload("res://icon.png")
	}
	items["glock45"] = {
		"id": 1,
		"type": "weapon",
		"weapon_type": "HandGun",
		"prefab": preload("res://Prefabs/Glock45.tscn"),
		"prefab_pickable": preload("res://Prefabs/PickableItems/Glock45.tscn"),
		"texture": preload("res://Prefabs/PickableItems/glock45.png")
	}
	items["ak47"] = {
		"id": 2,
		"type": "weapon",
		"weapon_type": "Rifle",
		"prefab": preload("res://Prefabs/Ak47.tscn"),
		"prefab_pickable": preload("res://Prefabs/PickableItems/Ak47.tscn"),
		"texture": preload("res://Prefabs/PickableItems/ak47.png")
	}