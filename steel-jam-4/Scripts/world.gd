extends Node2D

@export var RoomsArray: Array[PackedScene] = []
@export var RoomsToLoad: int = 5

var NextSpawnPosition: Vector2 = Vector2(1152,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range (RoomsToLoad):
		SpawnNextRoom()

func SpawnNextRoom():
	#Just in case the array is empty
	if RoomsArray.is_empty():
		return
	
	#Finding next room
	var Instance = RoomsArray.pick_random().instantiate()
	
	#Spawning the room
	Instance.position = NextSpawnPosition
	add_child(Instance)
	
	#Setting the next position
	NextSpawnPosition = Instance.get_node("EndMarker").global_position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
