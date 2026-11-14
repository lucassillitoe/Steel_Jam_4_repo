extends Node

#The current state of input
enum state {INPUTTING, PLAYING_BACK}
@onready var currentState := state.INPUTTING
@onready var PlayerPosition : Vector2
