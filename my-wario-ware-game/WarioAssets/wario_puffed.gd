extends CharacterBody2D

@export var float_speed : float = -100.0
@export var thruster_force : float = 200.0
@export var friction : float = 450.0

@onready var sprite = $AnimatedSprite2D

var environmental_wind : float = 0.0

func _physics_process(delta):
	
	velocity.y = float_speed

	if Input.is_action_just_pressed("move_left"):
		sprite.play("Burp")
		velocity.x = -thruster_force
	elif Input.is_action_just_pressed("move_right"):
		sprite.play("Fart")
		velocity.x = thruster_force
	
	else:
		#velocity.x = move_toward(velocity.x, 0, friction * delta)
		
		if sprite.animation != "Float" and not sprite.is_playing():
			sprite.play("Float")
		
		velocity.x = move_toward(velocity.x, environmental_wind, friction * delta)

	move_and_slide()


func _on_bee_body_entered(body):
	sprite.play("Inflate")
	await sprite.animation_finished
	set_physics_process(true)
