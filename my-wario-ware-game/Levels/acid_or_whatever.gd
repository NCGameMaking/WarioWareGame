extends Area2D


func _on_body_entered(body):
	if not body.is_in_group("Player"):
		print("not playerr")
	else:
		print("hit player")
		body.take_damage(3)
		$"../../UI/DeathMenu/Panel/YL/DeathMessage".text = "Wario Drowned In Acid"
		
