extends Node

#Reference to the player
@onready var player =  $"../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")
	
	player.MoveHorizontal(direction, delta)
	
	if Input.is_action_just_pressed("Jump"):
		player.Jump()
