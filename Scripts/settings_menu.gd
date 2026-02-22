extends Control

# TODO: Eventually migrate this whole system to something with autoload singletons in project settings

var SELECTED: Theme = preload("uid://be5h05f4havy0")
var config = Settings.config

@onready var color_picker_button: ColorPickerButton = $"MarginContainer/TabContainer/Board Settings/Control/ColorPickerButton"
@onready var board_settings: VBoxContainer = $"MarginContainer/TabContainer/Board Settings"
@onready var highlight_houses: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox"
@onready var highlight_orthogonal: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox2"
@onready var highlight_same_value: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox3"
@onready var highlight_candidates: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox4"
@onready var display_mode: OptionButton = $"MarginContainer/TabContainer/Board Settings/HBoxContainer/OptionButton"

func stylize_color_picker():
	var color_picker = color_picker_button.get_picker()
	color_picker.sampler_visible = false
	color_picker.color_modes_visible = false
	color_picker.sliders_visible = false
	color_picker.hex_visible = false
	color_picker.presets_visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	load_settings()
	stylize_color_picker()
	pass # Replace with function body.

func load_settings():
	
	highlight_houses.button_pressed = config.get_value("board_settings", "highlight_houses")
	highlight_orthogonal.button_pressed = config.get_value("board_settings", "highlight_orthogonal")
	highlight_same_value.button_pressed = config.get_value("board_settings", "highlight_same_value")
	highlight_candidates.button_pressed = config.get_value("board_settings", "highlight_candidates")
	color_picker_button.color = config.get_value("board_settings", "highlight_color")
	display_mode.selected = config.get_value("board_settings", "display_mode")
	update_game_settings()
	
func save_settings():
	config.set_value("board_settings", "highlight_houses", highlight_houses.button_pressed)
	config.set_value("board_settings", "highlight_orthogonal", highlight_orthogonal.button_pressed)
	config.set_value("board_settings", "highlight_same_value", highlight_same_value.button_pressed)
	config.set_value("board_settings", "highlight_candidates", highlight_candidates.button_pressed)
	config.set_value("board_settings", "highlight_color", color_picker_button.color)
	config.set_value("board_settings", "display_mode", display_mode.selected)
	Settings.save()

func update_game_settings():
	SELECTED.get_stylebox("normal", "Button").bg_color = config.get_value("board_settings", "highlight_color")
	
