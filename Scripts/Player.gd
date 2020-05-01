extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3
onready var head = $Head
onready var camera = $Head/Camera
onready var carry_item = $Head/Camera/Weapon
onready var inventory = $Inventory.get_node("Bag")
onready var crosshair = $Hud/Crosshair
onready var healthBar = $Hud/HealthBar
onready var stats_manager = $StatsManager
onready var weapon_manager = $Weapon
onready var spawn_item = $SpawnItem


export var decay = .001

var velocity = Vector3()
var camera_x_rotation = 0
var on_menu = false
var main_menu = null


var is_dead = false

func _ready():
	global.mouse_focus()
	pass
func _input(event):
	if is_dead:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return
	if event.is_action_pressed("ui_inventory"):
		inventory.visible = !inventory.visible
			
		if inventory.visible:
			Input.set_custom_mouse_cursor(null, Input.CURSOR_DRAG)
			InventoryUi.update()
			crosshair.visible = false
			global.mouse_select()
			on_menu = true
		else:
			global.mouse_focus()
			crosshair.visible = true
			on_menu = false
	
	if on_menu:
		return 
	if event is InputEventMouseMotion and !inventory.visible:
		head.rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta
	
	if Input.is_action_just_pressed("primary_fire"):
		"""
		var tmp = stats_manager.get_health() - 10
		stats_manager.set_health(tmp)
		"""
		spawn_item.create_item()
		"""
		var gun = carry_item.get_node("HandGun/Glock45")
		gun.get_node("AnimationPlayer").play("default")
		print(gun)
		"""

	weapon_manager.weapon_sway(event)

"""
func check_weapon_change():
	if Input.is_action_just_pressed("item_1"):
		carry_item.get_node("HandGun").visible = true
		carry_item.get_node("Rifle").visible = false
	elif Input.is_action_just_pressed("item_2"):
		carry_item.get_node("HandGun").visible = false
		carry_item.get_node("Rifle").visible = true
"""
	
func _physics_process(delta):
	if is_dead or on_menu:
		return 
	#check_weapon_change()
	weapon_manager.run_process(delta)
	check_death()
	var head_basis = head.get_global_transform().basis
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	velocity = move_and_slide(velocity, Vector3.UP)


func check_death():
	if stats_manager.get_health() == 0:
		is_dead = true
		print("dead")


func _on_StatsTimer_timeout():
	var thirst = stats_manager.get_thirst() * decay
	stats_manager.set_thirst(stats_manager.get_thirst() - thirst)
