extends Node

#The current state of input
enum state {INPUTTING, PLAYING_BACK, DEATH}
@onready var currentState := state.INPUTTING

@onready var PlayerPosition : Vector2
@onready var Score : int
