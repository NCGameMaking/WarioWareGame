extends Control

var time_elapsed := 0.0
var is_running := true

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../../WinMenu".position = Vector2(445,-2443)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_running:
		time_elapsed += delta
		$TimerLabel.text = "[shake amp=100.0 freq=10.0 speed=12.0][color=#FFEA00]"+str(time_elapsed).pad_decimals(0)+"[/color]
[/shake]"

func start_stopwatch():
	is_running = true
func stop_stopwatch():
	is_running = false
func reset_stopwatch():
	time_elapsed = 0.0
	$Label.text = "[shake amp=100.0 freq=10.0 speed=12.0][color=#FFEA00]00[/color]
[/shake]"


func _on_win_condition_body_entered(body):
	if body.is_in_group("Player"):
		stop_stopwatch()
		body.velocity = Vector2.ZERO
		body.set_physics_process(false)
		$AnimationPlayer.play("winanim")
		$"../../WinMenu/Panel/YL/WinMessage".text = "You got "+str(body.score)+" /12 coins and "+str(save_manager.bee_stings)+" bee stings!"
