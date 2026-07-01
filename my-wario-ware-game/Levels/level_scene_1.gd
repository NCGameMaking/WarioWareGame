extends Node2D

@onready var timer_label = $UI/TimerLabel
@onready var game_timer = $Timer


var on_ladder: bool = false
var climbing: bool = false
const CLIMB_SPEED = 150.0

var time_left : float  = 22.0

func _ready():
	player_stats.coin_count = 0
	time_left = 22
	game_timer.wait_time = 0.01
	game_timer.one_shot = false
	update_timer_text()
	game_timer.timeout.connect(_on_timer_timeout)
	
	if not player_stats.level_1_intro_played:
		$AnimationPlayer.play("wario_camera_drag")
		player_stats.level_1_intro_played = true
	else:
		$AnimationPlayer.advance(120)
		$Wario.visible = true

func _on_timer_timeout():
	if time_left > 0:
		time_left -= 0.01
		update_timer_text()
	else:
		game_timer.stop()
		game_over()
	
func update_timer_text():
	
	
	if time_left <= 5.0:
		var seconds = int(time_left)
		var msec = int((time_left - seconds) * 10) 
		var time_string = "%02d.%01d" % [seconds, msec]

		timer_label.text = "[shake amp=100.0 freq=10.0 speed=12.0][color=#E63946]" + time_string + "[/color][/shake]"
	else:
		var seconds = ceil(time_left)
		var time_string = "%02d" % seconds
		timer_label.text = "[color=#FFEA00]" + time_string + "[/color]"

func game_over():
	print("Wario ran out of time!")
	$LoseSFX.play()
	$UI/DeathMenu/Panel/YL/DeathMessage.text = "Wario ran out of time!"
	$Wario.game_over()
