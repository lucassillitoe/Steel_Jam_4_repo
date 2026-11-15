extends Control

@onready var highscore_label: Label = $Highscore
@onready var score_label: Label = $"../Score"
@onready var deathScore: Label = $Score

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	_refresh()

func _on_visibility_changed() -> void:
	if visible:
		_refresh()

func _refresh() -> void:
	var current_score := int(score_label.text)
	var highscore := int(SettingsManager.get_setting("GameStates", "Highscore"))
	deathScore.text = score_label.text
	
	if current_score > highscore:
		highscore = current_score
		SettingsManager.set_setting("GameStates", "Highscore", highscore)  # saves once
	
	highscore_label.text = str(highscore)

	# Your ScoreCard labels, read straight from the real settings
	for label in get_tree().get_nodes_in_group("ScoreCard"):
		var value = SettingsManager.get_setting(label.get_meta("Catagory"), label.get_meta("Key"))
		label.text = str(int(value)) if value != null else "0"


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ui.tscn")
