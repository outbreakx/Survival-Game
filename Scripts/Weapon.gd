extends Node

class_name Weapon

export var fire_rate = .5
export var clip_size = 5
export var reload_rate = 1
export var max_capacity = 120
export var fire_range = 100
export var fovChange = 15
export var fovSpeed = 5
export var aimSpeed = 7
export var xSwayAmount = 0.6
export var ySwayAmount = 0.3
export var xSwayMax = 1
export var ySwayMax = 0.4
var ySwaySmoothAmount = 2

var aimFov = null
var defaultFov = null

onready var bullet = preload("res://Prefabs/Bullet.tscn")


onready var aimingPosition = $"../Head/Camera/aimPosition"
onready var camera = $"../Head/Camera"
onready var raycast = $"../Head/Camera/WeaponRayCast"
onready var ammo = $"../Hud/Ammo"
onready var weapon = $"../Head/Camera/Weapon"
onready var cross = $"../Hud/Crosshair"

var reloading = false
var isAiming = false
var current_ammo = clip_size
var current_max_capacity = max_capacity
var normalPosition = null

var can_fire = true
var parent = null
func _ready():
	parent = get_parent()
	normalPosition = weapon.transform.origin

	defaultFov = camera.fov
	aimFov = camera.fov - fovChange
	raycast.cast_to = Vector3(0, 0, -fire_range)
	current_ammo = clip_size
	current_max_capacity = max_capacity
	ammo.set_text("%d/%d" % [current_ammo, current_max_capacity])

func weapon_sway(event):
	if event is InputEventMouseMotion:
		#parent.mouse += event.relative
		#parent.mouse = Vector2(int(parent.mouse.x) % int(get_viewport().size.x), int(parent.mouse.y) % int(get_viewport().size.y))
		
		var mouse = event

		mouse.position += event.relative

		var x = get_mouse_axis("x") * xSwayAmount
		var y = get_mouse_axis("y") * ySwayAmount
	
		var movX = clamp(x, -xSwayMax, xSwayMax)
		var movY = clamp(y, -ySwayMax, ySwayMax)
	
		var finalPos = Vector3(movX, movY, 0)
	
		weapon.transform.origin = lerp(weapon.transform.origin, normalPosition + finalPos, 0.004 * ySwaySmoothAmount)

func shot():
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		var bu = bullet.instance()	
		bu.get_node("RigidBody").transform.origin = weapon.transform.origin 
		self.add_child(bu)
		if current_ammo > 0 and !reloading:
			current_ammo -= 1
			can_fire = false
			yield(get_tree().create_timer(fire_rate), "timeout")
			can_fire = true
		elif !reloading:
			reloading = true
			current_max_capacity -= clip_size
			can_fire = false
			yield(get_tree().create_timer(reload_rate), "timeout")
			current_ammo = clip_size
			can_fire = true
			reloading = false
	elif Input.is_action_just_pressed("primary_aim"):
		isAiming = !isAiming

func update_text():
	if reloading:
		ammo.set_text("Reloading....")
	else:
		ammo.set_text("%d/%d" % [current_ammo, current_max_capacity])


func run_process(delta):
	if isAiming:
		cross.visible = false
	else:
		cross.visible = true
	update_text()
	weapon_movement(delta)
	check_collision()
	shot()
func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		
		if collider.is_in_group('enemies'):
			print("enemies")

func weapon_movement(delta):
	if isAiming:
		weapon.transform.origin = lerp(weapon.transform.origin, aimingPosition.transform.origin, delta * aimSpeed)
		camera.fov = lerp(camera.fov, aimFov - fovChange, delta * fovSpeed)
	else:
		weapon.transform.origin = lerp(weapon.transform.origin, normalPosition, delta * aimSpeed)
		camera.fov = lerp(camera.fov, defaultFov, delta * fovSpeed)	
		
func get_mouse_axis(name, mouse = null):
	var center = OS.get_window_size() / 2
	if mouse == null:
		mouse = get_viewport().get_mouse_position()
	
	var screen_left = Vector2(0, mouse.y)
	var screen_right = Vector2(OS.get_window_size().x, center.y)
	var screen_up = Vector2(center.x, 0)
	var screen_down = Vector2(center.x, OS.get_window_size().y)
	
	var perc = 0
	if name == "x":
		var dist_left = mouse.distance_to(screen_left)
		var dist_right = mouse.distance_to(screen_right)
		
		if dist_left < dist_right:
			var c = screen_left.distance_to(center)
			var m = mouse.distance_to(center)
			perc = min((m)/c, 1) * -1
		elif dist_left > dist_right:
			var c = screen_right.distance_to(center)
			var m = mouse.distance_to(center)
			perc = min((m)/c, 1)
		else:
			perc = 0
	elif name == "y":
		var dist_up = mouse.distance_to(screen_up)
		var dist_down = mouse.distance_to(screen_down)
		
		if dist_up < dist_down:
			var c = screen_up.distance_to(center)
			var m = mouse.distance_to(center)
			perc = min((m)/c, 1) * -1
		elif dist_up > dist_down:
			var c = screen_down.distance_to(center)
			var m = mouse.distance_to(center)
			perc = min((m)/c, 1)
		else:
			perc = 0
	return perc
