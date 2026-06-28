extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

var is_dead: bool = false

var on_ladder: bool = false
var climbing: bool = false
const CLIMB_SPEED = 150.0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var garlic_1 = $Control/Garlic1
@onready var garlic_2 = $Control/Garlic2
@onready var garlic_3 = $Control/Garlic3
@onready var collision_shape_2d = $CollisionShape2D

var health = 3

func _ready():
	$AnimationPlayer.active = true

func _physics_process(delta):
	# Add the gravity.
	if is_dead:
		velocity += get_gravity() * delta
		move_and_slide()
		return

	if on_ladder and (Input.is_action_pressed("move_up") or (Input.is_action_pressed("move_down"))):
		climbing = true
		
		animated_sprite_2d.play("climb")
	if climbing:
		velocity.y = 0
		var climb_direction = Input.get_axis("move_up", "move_down")
		velocity.y = climb_direction * CLIMB_SPEED
		
		if Input.is_action_just_pressed("jump"):
			climbing = false
	else:
		if not is_on_floor():
			velocity += get_gravity() * delta

	if climbing and not is_dead:
		if velocity.y != 0:
			animated_sprite_2d.play("climb")
		else:
			animated_sprite_2d.pause()
	else:
		# Your normal ground/air animations
		if not is_on_floor():
			if velocity.y > 0:
				animated_sprite_2d.play("fall")
			

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction !=0:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = (direction < 0)
		if is_on_floor():
			animated_sprite_2d.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animated_sprite_2d.play("idle")

	move_and_slide()


func _on_ladder_zone_body_entered(body):
	if body.name == "Wario":
		on_ladder = true


func _on_ladder_zone_body_exited(body):
	if body.name == "Wario":
		on_ladder = false
		climbing = false


func take_damage(amount : int):
	health -= amount
	
	await get_tree().create_timer(0.5).timeout
	
	$AnimationPlayer.play("hurt")
	
	if health == 3:
		garlic_1.visible = true
		garlic_2.visible = true
		garlic_3.visible = true
		print("wario has 3 lives")
	if health == 2:
		garlic_1.visible = false
		garlic_2.visible = true
		garlic_3.visible = true
		print("wario has 2 lives")
	if health == 1:
		$AnimationPlayer.active = false
		garlic_1.visible = false
		garlic_2.visible = false
		garlic_3.visible = true
		print("wario has 1 live")
	
	if health <= 0:
		print("wario dead")
		game_over()
		garlic_1.visible = false
		garlic_2.visible = false
		garlic_3.visible = false
		
@onready var camera_2d = $Camera2D

func game_over():
	if is_dead:
		return
	
	is_dead = true
	
	animated_sprite_2d.play("death")
	collision_shape_2d.queue_free()
	velocity.y = -250.0
	print("Wario just died")
	camera_2d.reparent(get_tree().current_scene)
	
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://TitleSlide/title_screen.tscn")
