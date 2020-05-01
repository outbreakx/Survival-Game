extends ColorRect

onready var image = $SlotImage
var image_start = null
var mouseIn = false
var z_index = null



func _ready():
	image_start = image.get_position()
	z_index = image.z_index

func _input(event):
	if mouseIn and Input.is_action_pressed("primary_fire"):
		InventoryUi.holding_name = self.name
		var mouse = get_local_mouse_position()		
		image.set_position(mouse)
		image.z_index = 999

func _process(delta):
	pass
	
func _on_Slot_mouse_entered():
	if InventoryUi.holding_name:
		reset_image()
		InventoryUi.on_change_slot(InventoryUi.holding_name, name)
	mouseIn = true


func _on_Slot_mouse_exited():
	yield(get_tree().create_timer(0.1), "timeout")	
	InventoryUi.holding_name = null
	mouseIn = false
	reset_image()

func reset_image():
	image.set_position(image_start)
	image.z_index = z_index
