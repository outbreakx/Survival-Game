extends Node

class_name InventoryItem


var id = 0
var item = ""
var amount = 1
var texture = null
var type = null
var weapon_type = null

func _init(_item, _amount = 1, _name = ""):
	id = _item.id
	amount = _amount
	texture = _item.texture
	type = _item.type
	if _item.has("weapon_type"):
		weapon_type = _item.weapon_type
	item = _name
