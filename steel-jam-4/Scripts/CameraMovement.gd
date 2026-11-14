extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y = 0
	
	if GLOBAL_VARIABLES.currentState == GLOBAL_VARIABLES.state.INPUTTING:
		if Input.is_action_just_pressed("MoveCameraRight"):
			position.x += 50
	
		elif Input.is_action_just_pressed("MoveCameraLeft"):
			position.x -= 50
			
	else:
		position.x = GLOBAL_VARIABLES.PlayerPosition.x
		
