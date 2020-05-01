extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(_event):
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	global.mouse_select()

func _on_NewGame_button_down():
	global.new_game()

func _on_Quit_button_down():
	get_tree().quit()


func _on_ResumeGame_button_down():
	global.resume_game()
