extends Camera2D

var shake_amount : float = 0.0
var default_offset : Vector2

func _ready():
	default_offset = offset
	add_to_group("Camera")
	await get_tree().create_timer(2.6667).timeout
	shake(17)
	await get_tree().create_timer(1.5666).timeout
	shake(15)
	await get_tree().create_timer(1.2667).timeout
	shake(17)
	await get_tree().create_timer(5.6159).timeout
	shake(17)





func _process(delta):
	if shake_amount > 0:
		offset.x = default_offset.x + randf_range(-shake_amount, shake_amount)
		offset.y = default_offset.y + randf_range(-shake_amount, shake_amount)
		
		shake_amount = move_toward(shake_amount, 0.0, delta * 20.0)
	else:
		offset = default_offset

func shake(intensity: float):
	shake_amount = intensity
