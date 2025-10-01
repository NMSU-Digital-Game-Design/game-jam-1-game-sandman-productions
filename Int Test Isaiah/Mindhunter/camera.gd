extends Camera2D
@export var camera_speed = 150

func _process(delta):
	position.x += camera_speed * delta
