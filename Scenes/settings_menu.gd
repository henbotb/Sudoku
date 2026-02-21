extends Control

var config = ConfigFile.new()
var SELECTED: Theme = preload("uid://be5h05f4havy0")

@onready var color_picker_button: ColorPickerButton = $"MarginContainer/TabContainer/Board Settings/Control/ColorPickerButton"
@onready var board_settings: VBoxContainer = $"MarginContainer/TabContainer/Board Settings"
@onready var highlight_houses: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox"
@onready var highlight_orthogonal: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox2"
@onready var highlight_same_value: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox3"
@onready var highlight_candidates: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox4"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var color_picker = color_picker_button.get_picker()
	color_picker.sampler_visible = false
	color_picker.color_modes_visible = false
	color_picker.sliders_visible = false
	color_picker.hex_visible = false
	color_picker.presets_visible = false
	
	if config.load("user://game_settings.cfg") != OK:
		save_settings()

	load_settings()
	save_settings()

	config.save("user://game_settings.cfg")
	
	pass # Replace with function body.

func load_settings():
	print("Attempting to load settings")
	
	highlight_houses.button_pressed = config.get_value("board_settings", "highlight_houses")
	highlight_orthogonal.button_pressed = config.get_value("board_settings", "highlight_orthogonal")
	highlight_same_value.button_pressed = config.get_value("board_settings", "highlight_same_value")
	highlight_candidates.button_pressed = config.get_value("board_settings", "highlight_candidates")
	color_picker_button.color = config.get_value("board_settings", "highlight_color")
	update_game_settings()
	
func save_settings():
	print("Attempting to save settings")
	config.set_value("board_settings", "highlight_houses", highlight_houses.button_pressed)
	config.set_value("board_settings", "highlight_orthogonal", highlight_orthogonal.button_pressed)
	config.set_value("board_settings", "highlight_same_value", highlight_same_value.button_pressed)
	config.set_value("board_settings", "highlight_candidates", highlight_candidates.button_pressed)
	config.set_value("board_settings", "highlight_color", color_picker_button.color)
	
func update_game_settings():
	print("Updating game settings")
	print("Color:", config.get_value("board_settings", "highlight_color"))
	SELECTED.get_stylebox("Button", "").bg_color = config.get_value("board_settings", "highlight_color")
	
