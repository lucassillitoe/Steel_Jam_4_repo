extends CharacterBody2D

#Parameters for player movement
const SPEED = 500.0
const ACCLERATION = 5000.0
const GROUND_DECLERATION = 3000.0
const AIR_DECLERATION = 500.0

const JUMP_VELOCITY = 500.0

@onready var playerVelocity := velocity


func MoveHorizontal(inputAxis: float, delta: float) -> void:
	##Takes in inputAxis: a float between -1 and 1 and delta: the physics tick
	##and updates velocity for horizontal movement
	
	if inputAxis == -1:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Walk")
		$"Walk Particles".emitting = true
	elif inputAxis == 1:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Walk")
		$"Walk Particles".emitting = true
	
	if inputAxis:
		var targetSpeed := inputAxis * SPEED
		velocity.x = move_toward(velocity.x, targetSpeed, ACCLERATION * delta)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, GROUND_DECLERATION * delta)
		$"Walk Particles".emitting = false
	else:
		velocity.x = move_toward(velocity.x, 0, AIR_DECLERATION * delta)
	
	playerVelocity = velocity


func Jump() -> void:
	##Updates velocity for horizontal movement
	if is_on_floor():
		$JumpSound.play()
		velocity.y = -JUMP_VELOCITY
		playerVelocity = velocity


func CheckIfDied() -> bool:
	## (check for layer 2 to kill player)
	## Checks if the player is touching layer 2 
	## Returns true if it is false if it isnt
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var layer = PhysicsServer2D.body_get_collision_layer(collision.get_collider_rid())
		if layer & (1 << 1):  # bit 1 = physics layer 2
			return true
	return false

func _physics_process(delta: float) -> void:
	# Add the gravity for the player.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if velocity.x <= 0.5 and velocity.x >= -0.5 and velocity.y <= 0.5 and velocity.y >= -0.5: 
		$AnimatedSprite2D.play("Idle")
	
	#Adds a reference for velocity for other scripts
	playerVelocity = velocity
	
	#Adds a reference for position
	GLOBAL_VARIABLES.PlayerPosition = self.position
	
	move_and_slide()
	
	# check if the player is touching layer 2 to kill him
	if CheckIfDied():
		#print('gg')
		pass




func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "Walk":
		$WalkSound.play()
