extends Control

@onready var save_button: TextureButton = $Settings/Save
@onready var reset_button: TextureButton = $Settings/Reset

var _pending := {}
var _listening_button: TextureButton = null
var _listening_action := ""
var _just_started_listening := false

func _ready() -> void:
	_pending = SettingsManager.settings.duplicate(true)
	_load_values_into_ui()
	save_button.pressed.connect(_on_save)
	reset_button.pressed.connect(_on_reset)
	for button in get_tree().get_nodes_in_group("Keybind_Button"):
		button.pressed.connect(_start_listening.bind(button, button.get_meta("Action")))
	for slider in get_tree().get_nodes_in_group("Setting_Slider"):
		slider.value_changed.connect(_on_slider_changed.bind(slider))


func _load_values_into_ui() -> void:
	for button in get_tree().get_nodes_in_group("Keybind_Button"):
		button.get_child(0).text = _pending["keybinds"].get(button.get_meta("Action"), "?")
	for slider in get_tree().get_nodes_in_group("Setting_Slider"):
		var val = _pending.get(slider.get_meta("Catagory"), {}).get(slider.get_meta("Key"), 0)
		slider.value = val
	
func _on_slider_changed(value: float, slider: HSlider) -> void:
	_pending[slider.get_meta("Catagory")][slider.get_meta("Key")] = int(value)


func _start_listening(button: BaseButton, Action: String) -> void:
	_listening_button = button
	_listening_action = Action
	button.get_child(0).text = "[Press a key.]"
	_just_started_listening = true


func _input(event: InputEvent) -> void:
	if _listening_button == null:
		return
	var key_name := ""
	if event is InputEventKey and event.pressed and not event.echo:
		key_name = OS.get_keycode_string(event.keycode)
	elif event is InputEventMouseButton and event.pressed:
		key_name = "Mouse" + str(event.button_index)
	else:
		return
	_pending["keybinds"][_listening_action] = key_name
	_listening_button.get_child(0).text = key_name
	_listening_button = null
	_listening_action = ""
	get_viewport().set_input_as_handled()

func _on_save() -> void:
	for category: String in _pending:
		for key: String in _pending[category]:
			SettingsManager.settings[category][key] = _pending[category][key]
	for action: String in _pending["keybinds"]:
		SettingsManager.set_keybind(action, _pending["keybinds"][action])
	SettingsManager.save_settings()

func _on_reset() -> void:
	SettingsManager.reset_to_defaults()
	_pending = SettingsManager.settings.duplicate(true)
	_load_values_into_ui()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Menu"):
		$Settings.hide()
		$"Main Menu".show()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_settings_pressed() -> void:
	$"Main Menu".hide()
	$Settings.show()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_audio_button_pressed() -> void:
	$Settings/Audio.show()
	$Settings/Keybinds.hide()


func _on_keybinds_button_pressed() -> void:
	$Settings/Audio.hide()
	$Settings/Keybinds.show()
