extends Node

var config = ConfigFile.new()
@onready var settings_menu: Control = $SettingsMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO: delete these lines, resets config for testing purpose
	var dir = DirAccess.open("user://")
	dir.remove("game_settings.cfg")
	
	set_defaults()
	
	if config.load("user://game_settings.cfg") != OK:
		printerr("User didn't have a game_settings.cfg")
		save()

func update_value():
	pass

func save():
	config.save("user://game_settings.cfg")
	
func _notifications(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save()
		
func set_defaults():
	config.set_value("board_settings", "highlight_houses", true)
	config.set_value("board_settings", "highlight_orthogonal", true)
	config.set_value("board_settings", "highlight_same_value", true)
	config.set_value("board_settings", "highlight_candidates", true)
	config.set_value("board_settings", "highlight_color", Color.CADET_BLUE)
	config.set_value("board_settings", "display_mode", 0)
