extends Node2D
@export var World: Node2D

var DontDelete: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func Reposition():
	if self.position.x != GLOBAL_VARIABLES.PlayerPosition.x:
		$"../Position".position = self.position
		if (self.position.x - 500) <= GLOBAL_VARIABLES.PlayerPosition.x and (self.position.x + 500) >= GLOBAL_VARIABLES.PlayerPosition.x:
			self.position.x = GLOBAL_VARIABLES.PlayerPosition.x
		elif self.position.x > GLOBAL_VARIABLES.PlayerPosition.x:
			self.position.x -= 500
		elif self.position.x < GLOBAL_VARIABLES.PlayerPosition.x:
			self.position.x += 500


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y = -140
	
	if GLOBAL_VARIABLES.currentState == GLOBAL_VARIABLES.state.INPUTTING:
		if Input.is_action_just_pressed("MoveCameraRight"):
			position.x += 50
			$"../Position".position = self.position
			
		elif Input.is_action_just_pressed("MoveCameraLeft"):
			position.x -= 50
			$"../Position".position = self.position
	else:
		Reposition()
