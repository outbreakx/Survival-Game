extends CanvasLayer

onready var ammo = $Ammo
onready var fps = $Fps
onready var crosshair = $Crosshair
onready var pick = $Pick
onready var health_bar = $HealthBar
onready var thirst_bar = $ThirstBar

const fps_x = -50
const fps_y = 20

const ammo_x = -100
const ammo_y = -75

const pick_x = -40
const pick_y = -50

const health_bar_y = -100
const health_bar_x = 20

const thisrt_bar_y = -80
const thirst_bar_x = 20

func fix_fps():	
	var screen = OS.get_window_size()
	fps.rect_position = Vector2(screen.x + fps_x, fps_y)
	
func fix_ammo():
	var screen = OS.get_window_size()
	ammo.rect_position = Vector2(screen.x + ammo_x, screen.y + ammo_y)
	
func fix_crosshair():
	crosshair.position = OS.get_window_size() / 2
	
func fix_pick():
	var screen = OS.get_window_size()
	pick.rect_position = Vector2(screen.x/2 + pick_x, screen.y/2 + pick_y)

func fix_health_bar():
	var screen = OS.get_window_size()
	health_bar.rect_position = Vector2(health_bar_x, screen.y + health_bar_y)

func fix_thirst_bar():
	var screen = OS.get_real_window_size()
	thirst_bar.rect_position = Vector2(thirst_bar_x, screen.y + health_bar_y)

func _ready():
	fix_fps()
	fix_ammo()
	fix_crosshair()
	fix_pick()
	fix_health_bar()
	fix_thirst_bar()
	get_tree().get_root().connect("size_changed", self, "window_resized")
	
func _process(delta):
	fps.text = str(Engine.get_frames_per_second())

	
func window_resized():
	fix_fps()
	fix_ammo()
	fix_crosshair()
	fix_pick()
	fix_health_bar()
	fix_thirst_bar()
