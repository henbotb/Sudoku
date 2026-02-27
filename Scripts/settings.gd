extends Node

var config = ConfigFile.new()

var highlight_houses: bool
var highlight_orthogonal: bool
var highlight_same_value: bool
var highlight_candidates: bool
var highlight_empty_cells: bool
var highlight_all: bool

var highlight_color: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO: delete these lines, resets config for testing purpose
	#var dir = DirAccess.open("user://")
	#dir.remove("game_settings.cfg")

	
	if config.load("user://game_settings.cfg") != OK:
		printerr("User didn't have a game_settings.cfg")
	
	load_settings()
	save()

func load_settings():
	highlight_houses = config.get_value("board_settings", "highlight_houses", true)
	highlight_orthogonal = config.get_value("board_settings", "highlight_orthogonal", true)
	highlight_same_value= config.get_value("board_settings", "highlight_same_value", true)
	highlight_candidates = config.get_value("board_settings", "highlight_candidates", true)
	highlight_empty_cells = config.get_value("board_settings", "highlight_empty_cells", true)
	highlight_all = config.get_value("board_settings", "highlight_all", false)
	
	highlight_color = config.get_value("board_settings", "highlight_color", Color.ROYAL_BLUE)


func save():
	config.set_value("board_settings", "highlight_houses", highlight_houses)
	config.set_value("board_settings", "highlight_orthogonal", highlight_orthogonal)
	config.set_value("board_settings", "highlight_same_value", highlight_same_value)
	config.set_value("board_settings", "highlight_candidates", highlight_candidates)
	config.set_value("board_settings", "highlight_empty_cells", highlight_empty_cells)
	config.set_value("board_settings", "highlight_all", highlight_all)
	
	config.set_value("board_settings", "highlight_color", highlight_color)

	config.save("user://game_settings.cfg")
	
func _notifications(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save()
