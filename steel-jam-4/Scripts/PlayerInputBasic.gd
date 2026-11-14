extends Node

#Here to prevent errors
enum state {INPUTTING, PLAYING_BACK}
@onready var currentState := state.INPUTTING

#Reference to the player
@export var player: CharacterBody2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GLOBAL_VARIABLES.PlayerPosition = player.position
	var direction := Input.get_axis("Left", "Right")
	
	player.MoveHorizontal(direction, delta)
	
	if Input.is_action_just_pressed("Jump"):
		player.Jump()
