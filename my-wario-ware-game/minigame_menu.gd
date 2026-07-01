extends Control

@onready var label1 = $ButtonMinigame1/Label
@onready var label2= $ButtonMinigame2/Label
@onready var label3 = $ButtonMinigame3/Label
@onready var label4 = $ButtonMinigame4/Label
@onready var label5 = $ButtonMinigame5/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	display_high_scores()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func display_high_scores():
	label1.text = "High Score: " + str(save_manager.high_scores["minigame1"])

func _on_button_minigame_1_pressed():
	get_tree().change_scene_to_file("res://Levels/level_scene_1.tscn")
	player_stats.coin_count = 0
