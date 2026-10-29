extends Area2D


@export var move_direction : Vector2
@export var move_speed : float = 50
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $"../AnimationPlayer"
@onready var war_coll = $"../WarioPuffed/CollisionShape2D"
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
		save_manager.bee_stings+=1
		$"../WarioPuffed/CollisionShape2D".set_deferred("disabled", true)
		$"../WarioStingEnemy"
		body.set_physics_process(false)
		body.sprite.play("Deflate")
		var floor_y = 1070.0
		var distance = abs(floor_y - body.position.y)
		var fall_speed=600.0
		var fall_duration = distance/fall_speed
		save_manager.bee_stings+=1
		var drop_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		drop_tween.tween_property(body, "position:y", floor_y,fall_duration)
		await drop_tween.finished
		body.sprite.play("normal")
		var sting_pos = body.global_position
		animation_player.play("wario_bee_sting")
		await animation_player.animation_finished
		var bee_sting_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		bee_sting_tween.tween_property($"../Bee","global_position",sting_pos,1)
		body.sting_pos = global_position
		$"../WarioPuffed/CollisionShape2D".set_deferred("disabled", false)
