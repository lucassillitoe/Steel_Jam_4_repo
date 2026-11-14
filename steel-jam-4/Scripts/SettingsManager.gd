extends Node
 
const SETTINGS_FILE := "C://Users/Public/Documents/Config.json"
 
var settings := {
	"audio": {
		"master_volume": 100,
		"music_volume": 100,
		"sfx_volume": 100,
	},
	"keybinds": {
		"Right": "D",
		"Left": "A",
		"Jump": "Space",
		"Menu": "Escape",
		"Playback": "Enter",
	}
}

 
var _defaults := {}
 
func _ready() -> void:
	_defaults = settings.duplicate(true)
	load_settings()#
	_apply_all_keybinds()
 
func save_settings() -> void:
	var file := FileAccess.open(SETTINGS_FILE, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(settings, "\t"))
		load_settings()
 
func load_settings() -> void:
	if not FileAccess.file_exists(SETTINGS_FILE):
		return
	var file := FileAccess.open(SETTINGS_FILE, FileAccess.READ)
	if not file:
		return
	var json := JSON.new()
	if json.parse(file.get_as_text()) == OK:
		for Catagory in json.data:
			if settings.has(Catagory):
				settings[Catagory].merge(json.data[Catagory], true)
 
func reset_to_defaults() -> void:
	settings = _defaults.duplicate(true)
	save_settings()
 
func get_setting(Catagory: String, Key: String) -> Variant:
	return settings.get(Catagory, {}).get(Key, null)
 
func set_setting(Catagory: String, Key: String, value: Variant) -> void:
	settings[Catagory][Key] = value
	save_settings()

func _apply_all_keybinds() -> void:
	for Action in settings["keybinds"]:
		set_keybind(Action, settings["keybinds"][Action])
		

func set_keybind(Action: String, key_string: String) -> void:
	settings["keybinds"][Action] = key_string
	InputMap.action_erase_events(Action)
	if key_string.begins_with("Mouse"):
		var ev := InputEventMouseButton.new()
		ev.button_index = key_string.replace("Mouse", "").to_int()
		InputMap.action_add_event(Action, ev)
	else:
		var ev := InputEventKey.new()
		ev.keycode = OS.find_keycode_from_string(key_string)
		InputMap.action_add_event(Action, ev)
	save_settings()
