extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var jump_count = 0
	
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
		
	# Handle animation
	if is_on_floor():
		if jump_count > 0:
			jump_count = 0
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		print(jump_count)
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		print(jump_count)
	
	if direction > 0:
		animated_sprite.flip_h = false
		velocity.x = direction * SPEED
	elif direction < 0:
		animated_sprite.flip_h = true
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
