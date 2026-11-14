extends CharacterBody2D


const SPEED = 500.0
const ACCLERATION = 100.0
const GROUND_DECLERATION = 30.0
const AIR_DECLERATION = 5.0
const JUMP_VELOCITY = 500.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		var nextSpeed := direction * SPEED
		velocity.x = move_toward(velocity.x, nextSpeed, ACCLERATION)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, GROUND_DECLERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, AIR_DECLERATION)
	
	move_and_slide()
