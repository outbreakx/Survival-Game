extends Node

class_name Interactable
export var item = ""

func get_interaction_text():
	return "Interact with %s" % item

func interact():
	print("Interacted with %s" % item)
