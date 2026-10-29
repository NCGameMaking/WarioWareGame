extends CharacterBody2D
var score :int = 0
@export var float_speed : float = -100.0
@export var thruster_force : float = 200.0
@export var friction : float = 450.0
@onready var sprite = $AnimatedSprite2D
@onready var sting_pos : Vector2 = global_position
@onready var animation_player = $"../AnimationPlayer"
var already_stung:bool=false
var environmental_wind : float = 0.0
var just_popped = false
func _ready():
	score=0
	set_physics_process(false)
	animation_player.play("wario_bee_sting")
	await animation_player.animation_finished
	var bee_sting_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	bee_sting_tween.tween_property($"../Bee","global_position",sting_pos,1)
	await bee_sting_tween.finished

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


func _on_bee_body_entered(_body):
	sprite.play("Inflate")
	set_physics_process(true)
	$"../WarioSting".play()
func increase_score(add_score:int):
	score +=add_score
	$Control/CoinLabel.text = "[color=#FFE20]x "+str(score)+"[/color]"
