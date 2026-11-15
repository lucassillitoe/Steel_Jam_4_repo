extends Node2D

@export var RoomsArray: Array[PackedScene] = []
@export var RoomsToLoad: int = 3
@export var Player: CharacterBody2D

var PlayerPosition: int
var DontDelete: int

#Arrays for keeping track of loading
var RoomOrderPosition: Array[Vector2] = []
var RoomsVisited: Array[Node2D] = []

const ChunkSize:= Vector2(1280, 720)

var NextSpawnPosition: Vector2 = Vector2(640, -500)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range (RoomsToLoad):
		SpawnNextRoom()
	PlayerPosition = ChunkFloor()

func SpawnNextRoom():
	#Just in case the array is empty
	if RoomsArray.is_empty():
		return
		
	#Finding next room
	var Instance = RoomsArray.pick_random().instantiate()

	#Adding the room to the visited array
	RoomsVisited.append(Instance)
	
	#Spawning the room
	Instance.position = NextSpawnPosition
	RoomOrderPosition.append(NextSpawnPosition)
	add_child(Instance)
	
	#Setting the next position
	NextSpawnPosition = Instance.get_node("EndMarker").global_position
	

func ChunkConvert():
	#Converts the players x and y coordinates to the chunk coordinates
	var Chunkx = $Position.global_position.x / ChunkSize.x
	return Chunkx
	
func ChunkFloor():
	#Rouds the value of the chunk the player is in down so it directly maps with the array.
	return ((floor(ChunkConvert())) - 1)

#The Function that gets called when the player moves right
func ChunkUnload():
	#This part handles reloading the chunks ahead of the player if theyve been removed
	#If there is more than two chunks ahead of the player that means some have been removed
	if (ChunkFloor() + 3) < len(RoomsVisited):
		#Adding back the chunks 
		add_child(RoomsVisited[(ChunkFloor() + 3)])
	#If the plater is past the 4th chunk mark it starts removing the chunks 3 positions behind
	if ChunkFloor() >= 3:
		if ChunkFloor() - 3 != DontDelete:
			remove_child(RoomsVisited[ChunkFloor() - 3]) 

#The function that gets called when the player moves left
func ChunkLoad():
	#If there is more than two chunks ahead of the player and the player moves left
	#It removes that chunk 
	if (ChunkFloor() + 3) < len(RoomsVisited):
		if ChunkFloor() + 3 != DontDelete:
			remove_child(RoomsVisited[ChunkFloor() + 4]) 
	#If the player is past the third chunk 
	if ChunkFloor() >= 2:
		RoomsVisited[ChunkFloor() - 2].position = RoomOrderPosition[ChunkFloor() - 2]
		add_child(RoomsVisited[ChunkFloor() - 2])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	DontDelete = floor(Player.global_position.x / ChunkSize.x)
	#Checks if the players position changees and if so what direction
	if ChunkFloor() != PlayerPosition:
		#If the player is moving to the right it calls the function to unload chunks
		if ChunkFloor() > PlayerPosition:
			ChunkUnload()
			PlayerPosition = ChunkFloor()
			#If there is only two more chunks ahead of the player it will spawn another
			if (ChunkFloor() + 3 == (len(RoomsVisited))):
				SpawnNextRoom()
		#If the player is moving to the left it calls the function to load previous chunks
		elif ChunkFloor() < PlayerPosition:
			ChunkLoad()
			PlayerPosition = ChunkFloor()
