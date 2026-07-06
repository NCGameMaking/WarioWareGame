extends Node2D

@onready var wario_puffed = $WarioPuffed
@onready var animated_sprite_2d = $WarioPuffed/AnimatedSprite2D
@onready var bee = $Bee

# Called when the node enters the scene tree for the first time.
func _ready():
	start_bee_transformation_scene()

func start_bee_transformation_scene():
	wario_puffed.set_physics_process(false)
	animated_sprite_2d.play("normal")

func turn_wario():
	pass
	
	
