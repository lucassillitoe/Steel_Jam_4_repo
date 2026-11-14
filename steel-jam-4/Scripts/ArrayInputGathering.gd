extends Node

#The current state of input
enum state {INPUTTING, PLAYING_BACK}
@onready var currentState := state.INPUTTING

#All the available inputs
enum inputs {JUMP, LEFT, RIGHT}

#variable for the list of inputs 
var inputContainer = []

#variable for the count for itterating through the list when playing back
var playbackIndex = 0 

#Reference to the player
@onready var player =  $"../Player"


#calls every frame
func _physics_process(delta: float) -> void:
	if currentState == state.INPUTTING:
		#reads keyboard input and appends to the array
		
		#Movement input for this frame
		var inputsThisFrame = []
		
		if Input.is_action_just_pressed("Jump"):
			inputsThisFrame.append(inputs.JUMP)
		if Input.is_action_pressed("Left"):
			inputsThisFrame.append(inputs.LEFT)
		if Input.is_action_pressed("Right"):
			inputsThisFrame.append(inputs.RIGHT)
			
		inputContainer.append(inputsThisFrame)
		
		
		#Finish movement sequence and play it
		if Input.is_action_just_pressed("Enter playback"):
			currentState = state.PLAYING_BACK
			playbackIndex = 0
		
		#print(inputContainer)
	
	
	#When playing back inputs
	if currentState == state.PLAYING_BACK and not inputContainer.is_empty():
		print("Playing back", playbackIndex, "/", len(inputContainer))
	
			
			#Executes the input
		var inputsThisTick = inputContainer[playbackIndex]
			
		if inputs.JUMP in inputsThisTick:
			player.Jump()
			
		var horizontalInputSum := 0
		if inputs.LEFT in inputsThisTick:
			horizontalInputSum -= 1
		if inputs.RIGHT in inputsThisTick:
			horizontalInputSum += 1
			
		player.MoveHorizontal(horizontalInputSum, delta)
			
			
			#Skips ahead if stationary to avoid waiting
		if player.playerVelocity == Vector2(0, 0):
			while inputContainer[playbackIndex] == [] and playbackIndex < len(inputContainer) - 1:
				playbackIndex += 1
			
			
			#When it reaches the end of the current sequence
		if playbackIndex >= len(inputContainer) - 1:
			currentState = state.INPUTTING
			inputContainer.clear()
				
				#Stops the player from moving
			player.MoveHorizontal(0, delta)
			
			
			#Increments the current step
		playbackIndex += 1
