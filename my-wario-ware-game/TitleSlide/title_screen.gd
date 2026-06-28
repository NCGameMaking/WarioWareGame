extends Control

var intro_playing : bool = true

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_scene_1.tscn")


func _on_settings_button_pressed():
	print("Settings to be added")


func _on_quit_button_pressed():
	get_tree().quit()
	
func _input(event):
	# Check if the player presses a "ui_accept" action (Space/Enter/Click) OR a custom skip key
	if intro_playing and (event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel")):
		skip_intro()

func skip_intro():
	intro_playing = false
	
	$AnimationPlayer.seek(14.0, true)
		
		# 3. Stop it there so it doesn't loop or keep processing
	#$AnimationPlayer.stop()
		
	print("Fast-forwarded straight to the end of the 16s intro!")
