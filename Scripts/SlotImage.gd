extends Sprite


var mouseIn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if mouseIn and Input.is_action_pressed("primary_fire"):
		set_position(get_viewport().get_mouse_position())
		
		

func _on_Area2D_mouse_entered():
	print("mouse entrou")
	mouseIn = true
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	mouseIn = false
	pass # Replace with function body.
