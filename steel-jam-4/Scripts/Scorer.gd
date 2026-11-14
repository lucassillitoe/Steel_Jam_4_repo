extends Node

@onready var score = 0
@export var Scorer: Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var playerPosition = GLOBAL_VARIABLES.PlayerPosition.x
	if playerPosition > Scorer.position.x:
		Scorer.position.x = playerPosition
	Scorer.position.y = 0
