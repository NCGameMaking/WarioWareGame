extends Control

@onready var label1 = $ButtonMinigame1/Label
@onready var label2= $ButtonMinigame2/Label

# Called when the node enters the scene tree for the first time

func _on_button_minigame_1_pressed():
	get_tree().change_scene_to_file("res://Levels/level_scene_1.tscn")
	player_stats.coin_count = 0

func _on_button_minigame_2_pressed():
	get_tree().change_scene_to_file("res://level_scene_2.tscn")


func _on_button_minigame_3_pressed():
	get_tree().change_scene_to_file("res://TitleSlide/title_screen.tscn")
