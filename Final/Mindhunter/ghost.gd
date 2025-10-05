extends CharacterBody2D

@export var speed = 75
var player
var anim

func _ready():
	anim = $AnimatedSprite2D
	# Delay search until scene tree is fully loaded
	call_deferred("_find_player")

func _find_player():
	# Try to find Escalator directly
	player = get_tree().root.find_child("Escalator", true, false)

func _physics_process(_delta):
	if player:
		var direction = (player.global_position - global_position)
		if direction.length() > 5: # don’t jitter when close
			velocity = direction.normalized() * speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Escalator": # Or check with `body.is_in_group("player")`
		$AnimatedSprite2D.play("attack")


func _on_area_2d_body_exited(body: Node2D) -> void:
	$AnimatedSprite2D.play("idle")
