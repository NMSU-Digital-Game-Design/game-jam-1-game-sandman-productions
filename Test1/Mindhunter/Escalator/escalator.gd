extends CharacterBody2D

var gravity = 350
var walkingVelocity = 220
var jumpVelocity = 220

signal beenHit;

var startedDown = false
var jumpCount = 0
var isRolling = false
var roll_time = 1.1  # how long a roll lasts (seconds)
var roll_timer = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Apply gravity
	if !is_on_floor():
		velocity.y += gravity * delta
		if (velocity.y > 0 and !startedDown and !isRolling):
			$AnimatedSprite2D.animation = "jump_down"
			$AnimatedSprite2D.play()
			startedDown = true
	else:
		velocity.y = 0
		startedDown = false
		jumpCount = 0

	# Handle rolling
	if isRolling:
		roll_timer -= delta
		velocity.x = walkingVelocity * 1.1  # constant forward movement during roll
		$AnimatedSprite2D.animation = "roll"
		$AnimatedSprite2D.play()
		if roll_timer <= 0:
			isRolling = false  # roll finished
	else:
		# Normal movement
		if Input.is_action_pressed("Right"):
			velocity.x = walkingVelocity
			if is_on_floor():
				$AnimatedSprite2D.animation = "walking"
				$AnimatedSprite2D.play()
			$AnimatedSprite2D.flip_h = false
		elif Input.is_action_pressed("Left"):
			velocity.x = -walkingVelocity
			if is_on_floor():
				$AnimatedSprite2D.animation = "walking"
				$AnimatedSprite2D.play()
			$AnimatedSprite2D.flip_h = true
		else:
			velocity.x = 0
			if is_on_floor():
				$AnimatedSprite2D.animation = "default"
				$AnimatedSprite2D.play()

		# Jump
		if Input.is_action_just_pressed("Jump") and (is_on_floor() or jumpCount < 2):
			velocity.y = -jumpVelocity
			$AnimatedSprite2D.animation = "jump_up"
			$AnimatedSprite2D.play()
			jumpCount += 1
			startedDown = false

		# Start roll
		if Input.is_action_just_pressed("Roll") and is_on_floor():
			isRolling = true
			roll_timer = roll_time
			$AnimatedSprite2D.animation = "roll"
			$AnimatedSprite2D.play()
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "roll":
		isRolling = false
