extends Node

export var health = 100
export var max_health = 100
export var thisrt = 100
export var max_thirst = 100

onready var healthbar = $"../Hud/HealthBar"
onready var thirst_bar = $"../Hud/ThirstBar"

# Called when the node enters the scene tree for the first time.
func _ready():
	healthbar.value = health
	healthbar.max_value = max_health
	
func set_health(_health):

	health = max(_health, 0)
	healthbar.value = health

func get_health():
	return health

func reset_health():
	healthbar.value = max_health

func set_thirst(_thirst):
	thisrt = max(_thirst, 0)
	thirst_bar.value = thisrt


func get_thirst():
	return thisrt