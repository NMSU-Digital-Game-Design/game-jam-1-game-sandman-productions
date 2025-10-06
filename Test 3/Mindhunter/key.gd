extends Sprite2D

@export var spin_speed = 3.0  # how fast it flips
signal key_collected
var scale_dir = 1
var player = null

# ADDED: which door this key unlocks (set per key in the Inspector)
@export var door_id:int = 1   # 1 → Door1, 2 → Door2, etc.

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

	# ADDED: give the key to the player (if it's the player), then remove key
	if body.is_in_group("Escalator"):
		if body.has_method("obtain_key"):
			body.obtain_key(door_id)
		queue_free()  # remove the key after pickup (kept separate from your existing lines)
