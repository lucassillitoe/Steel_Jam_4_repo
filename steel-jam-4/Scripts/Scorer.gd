extends Node

@onready var score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var playerPosition = GLOBAL_VARIABLES.PlayerPosition.x
	if playerPosition > self.position.x:
		self.position.x = playerPosition
