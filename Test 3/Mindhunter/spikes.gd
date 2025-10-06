extends CharacterBody2D

func _ready():
	pass
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Escalator"):
		body.show_blood()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Escalator"):
		body.stop_blood()
