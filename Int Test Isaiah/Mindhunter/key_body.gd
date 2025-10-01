extends Area2D

signal key_collected

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Escalator"):
		var sprite = get_parent().get_child(0)
		print(sprite)
		if sprite:
			sprite.visible = false
		emit_signal("key_collected")
