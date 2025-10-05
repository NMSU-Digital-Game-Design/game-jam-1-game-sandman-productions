extends Node2D

@export var open_distance = 120        # how much the door slides up
@export var speed = 200.0             # pixels per second
@export var trigger_left_distance = 80
@export var trigger_right_distance = 120
var can_open_door_one = false
var closed_position = Vector2()
var open_position = Vector2()
var player = null

func _ready():
	closed_position = position
	open_position = closed_position + Vector2(0, -open_distance)

func _process(delta):
	# Find the player automatically if we haven't yet
	if not player:
		var players = get_tree().get_nodes_in_group("Escalator")
		if players.size() > 0:
			player = players[0]
		else:
			return  # no player found yet

	# Calculate horizontal distance
	var horizontal_dist = abs(player.position.x - position.x)

	# Use different trigger distances depending on Player's X relative to door
	var trigger_distance = horizontal_dist
	if can_open_door_one:
		if player.position.x < position.x:
			trigger_distance = trigger_left_distance
		else:
			trigger_distance = trigger_right_distance

	# Open or close door based on horizontal distance
	if can_open_door_one:
		if horizontal_dist <= trigger_distance:
			position = position.move_toward(open_position, speed * delta)
		else:
			position = position.move_toward(closed_position, speed * delta)

func _on_key_area_key_collected() -> void:
	can_open_door_one = true


func _on_key_key_collected() -> void:
	pass # Replace with function body.
