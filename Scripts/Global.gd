extends Node


onready var main_menu = preload("res://Scenes/Menu.tscn")
onready var world_scene = preload("res://Scenes/World.tscn")
var current_scene = null
var menu_scene = null
var root = null

func _ready():
	menu_scene = main_menu.instance()
	current_scene = world_scene.instance()
	
	root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


	menu_scene.visible = false

func mouse_select():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
func mouse_focus():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func show_menu():
	root.remove_child(current_scene)
	global.add_child(menu_scene)

func resume_game():
	global.remove_child(menu_scene)
	root.add_child(current_scene)

func reset_inventory():
	InventoryUi.clear_items()
	InventoryManager.clear_items()
	
func new_game():
	current_scene.queue_free()
	reset_inventory()
	current_scene = world_scene.instance()
	root.add_child(current_scene)

	if menu_scene.visible:
		global.remove_child(menu_scene)
		menu_scene.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if menu_scene.visible:
			resume_game()
		else:
			show_menu()
		menu_scene.visible = !menu_scene.visible
