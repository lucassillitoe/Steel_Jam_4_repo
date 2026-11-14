extends CharacterBody2D


const SPEED = 500.0
const ACCLERATION = 5000.0
const GROUND_DECLERATION = 3000.0
const AIR_DECLERATION = 500.0
const JUMP_VELOCITY = 500.0


func MoveHorizontal(inputAxis: float, delta: float) -> void:
	##Takes in inputAxis: a float between -1 and 1 and delta: the physics tick
	##and updates velocity for horizontal movement
	
	if inputAxis:
		var targetSpeed := inputAxis * SPEED
		velocity.x = move_toward(velocity.x, targetSpeed, ACCLERATION * delta)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, GROUND_DECLERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, AIR_DECLERATION * delta)


func Jump() -> void:
	##Updates velocity for horizontal movement
	if is_on_floor():
		velocity.y = -JUMP_VELOCITY


func _physics_process(delta: float) -> void:
	# Add the gravity for the player.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	move_and_slide()
