extends Node

<<<<<<< Updated upstream
@onready var player =  $"../Player"
=======
@onready var player = get_node("/root/Player")
>>>>>>> Stashed changes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")
	
<<<<<<< Updated upstream
	player.MoveHorizontal(direction, delta)
	
	if Input.is_action_just_pressed("Jump"):
		player.Jump()
=======
	player.get_script().MoveHorizontal(direction, delta)
	
>>>>>>> Stashed changes
