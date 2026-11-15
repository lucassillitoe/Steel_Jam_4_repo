extends Node

@export var scoreDisplay : Label

var thisPlaybackStartPos := 0
var thisPlaybackStartScore := 0

var distanceTravelledThisPlayback := 0
var scoreGainedThisPLayback := 0
var scoreLostThisPLayback := 0

var scoreDecay := 0

func Score(distance: float) -> int:
	return round((distance ** 2) * (10.0 ** -2))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = -140


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scoreDecay = round(delta * 600)
	
	#Finds the player position
	var playerPosition = GLOBAL_VARIABLES.PlayerPosition.x
	if playerPosition > self.position.x:
		self.position.x = playerPosition
	
	#Keeps a reference to where the player was, to do Score based on distance moved this playback
	if GLOBAL_VARIABLES.currentState == GLOBAL_VARIABLES.state.INPUTTING:
		thisPlaybackStartPos = self.position.x
		thisPlaybackStartScore = GLOBAL_VARIABLES.Score
		
		#Decreases Score over time
		GLOBAL_VARIABLES.Score -= scoreDecay
		scoreLostThisPLayback = 0
	
	else:
		#Score increases non-linearly with distance travelled this playback and decreases linearly with time
		distanceTravelledThisPlayback = max(playerPosition - thisPlaybackStartPos, 0)
		scoreGainedThisPLayback = Score(distanceTravelledThisPlayback)

		GLOBAL_VARIABLES.Score = thisPlaybackStartScore + scoreGainedThisPLayback - scoreLostThisPLayback
		scoreLostThisPLayback += scoreDecay
	
	#Prevents negative Score
	GLOBAL_VARIABLES.Score = max(GLOBAL_VARIABLES.Score, 0)
	
	#Updates Score display
	scoreDisplay.text = str(GLOBAL_VARIABLES.Score)
