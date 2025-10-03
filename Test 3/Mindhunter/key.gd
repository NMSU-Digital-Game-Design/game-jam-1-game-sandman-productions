extends Sprite2D

@export var spin_speed = 3.0  # how fast it flips
signal key_collected
var scale_dir = 1
var player = null
func _process(delta):
	# fake X-axis rotation by scaling X back and forth
	scale.x += spin_speed * delta * scale_dir
	if scale.x > 1 or scale.x < -1:
		scale_dir *= -1  # reverse direction
		scale.x = clamp(scale.x, -1, 1)
	if not player:
		var players = get_tree().get_nodes_in_group("Escalator")
		if players.size() > 0:
			player = players[0]
		else:
			return  # no player found yet

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	hide()
	emit_signal("key_collected")
