extends Area2D


@export var move_direction : Vector2
@export var move_speed : float = 50
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var start_pos : Vector2 = global_position
@onready var target_pos : Vector2 = global_position + move_direction


func _physics_process(delta):
	if animated_sprite_2d.animation !="attack":
		animated_sprite_2d.play("fly")
	
	if target_pos.x < global_position.x:
		animated_sprite_2d.flip_h = true
	elif target_pos.x > global_position.x:
		animated_sprite_2d.flip_h = false
	
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	
	if global_position == target_pos:
		if target_pos == start_pos:
			target_pos = start_pos + move_direction
		else :
			target_pos = start_pos
			

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.sprite.play("Deflate")
		body.set_physics_process(false)
		body.velocity.y = 500
		$"../WarioPuffed/CollisionShape2D".disabled = true
		body.just_popped = true
