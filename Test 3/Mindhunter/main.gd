extends Node2D

var hitCount = 0

@export var escalatorScene: PackedScene
var escalator
var camera

func _ready() -> void:
	escalator = escalatorScene.instantiate()
	escalator.position = Vector2(500,10);
	add_child(escalator);
	
	#instantiate camera
	camera = Camera2D.new();
	camera.zoom = Vector2(2,2);
	escalator.add_child(camera)
