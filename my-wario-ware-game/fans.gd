extends Node2D

@export var set_drift_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$IndustrialFanBlade.rotation_degrees -= 500 * delta

func _on_area_2d_body_entered(body):
	if body.name == "WarioPuffed":
		body.environmental_wind = set_drift_speed


func _on_area_2d_body_exited(body):
	if body.name == "WarioPuffed":
		body.environmental_wind = 0.0
