extends Area2D

@onready var game_timer = $"../Timer"
@onready var win_menu = $"../UI/WinMenu"


func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	
	if not body.is_in_group("Player"):
		print("not player")
	else:
		body.velocity = Vector2.ZERO
		body.set_physics_process(false)
		
		if game_timer:
			game_timer.stop()
			print("timers frozan")
		if win_menu:
			$"../WinSound".play()
			$"../WarioWinSound".play()
			$"../AnimationPlayer".play("winPushdown")
			$"../UI/WinMenu/Panel/YL/WinMessage".text = "Wario beat the level with " + str(player_stats.coin_count) + "/12 coins!"
			
			var is_new_record = save_manager.update_high_score("minigame1", player_stats.coin_count)
			
			if is_new_record:
				print("New local record set!")
				$"../UI/WinMenu/Panel/YL/WinMessage".text += "\nNEW HIGH SCORE!"
				print("Was it a new high score? ", is_new_record)
				print("Saved high score table is now: ", save_manager.high_scores)
			
