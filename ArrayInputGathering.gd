extends Node

#variable for the list of inputs 
var inputContainer = []

#variable for the count for itterating through the list
var count = 0 

#sub in for the player in the scene
@onready var player : CharacterBody2D

#calls every frame
func _process(delta: float) -> void:
	#reads keyboard input and appends to the array
	if Input.is_action_just_pressed("ui_accept"):
		inputContainer.append("ui_accept")
	elif Input.is_action_just_pressed("ui_right"):
		inputContainer.append("ui_right")
	elif Input.is_action_just_pressed("enter"):
		inputContainer.append("enter")
	print(inputContainer)
	
	#check is array contains elements
	if not inputContainer.is_empty():
		#runs only if enter has been pressed
		if inputContainer.back() == "enter":
			#is the player not moving/ action has been completed
			if player.velocity.y <= 0.05 and player.velocity.x <= 0.05 and velocity.y >= -0.05:
				#inputs for left, right, jump, etc
				#when adding in an action add one to count each time
				if inputContainer[count] == "ui_accept":
					
					count += 1
				elif inputContainer[count] == "ui_right":
					
					count += 1
				#enter is for the end of the array
				elif inputContainer[count] == "enter":
					#clears the array to start again
					inputContainer.clear()
					#resets count for itteration
					count = 0
	
