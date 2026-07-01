extends Area2D


var rotate_speed : float = 3.0
var bob_height  : float = 5.0
var bob_speed : float = 4.0

@onready var start_pos : Vector2 = global_position
@onready var coin_sprite = $CoinSprite

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	var time = Time.get_unix_time_from_system()
	
	coin_sprite.scale.x = sin(time * rotate_speed)
	
	var y_pos = ((1+sin(time * bob_speed))/2) * bob_height
	global_position.y = start_pos.y - y_pos

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
		print("not player")

	else:
		body.increase_score(1)
		print("player collected 1 coin")
		queue_free()
