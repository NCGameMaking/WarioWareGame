extends Control

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	player_stats.coin_count = 0

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://minigame_menu.tscn")
	


func _on_next_stage_button_pressed():
	get_tree().change_scene_to_file("res://level_scene_2.tscn")
