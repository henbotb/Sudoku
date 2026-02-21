extends Control

var config = ConfigFile.new()
var SELECTED: Theme = preload("uid://be5h05f4havy0")

@onready var color_picker_button: ColorPickerButton = $"MarginContainer/TabContainer/Board Settings/Control/ColorPickerButton"
@onready var board_settings: VBoxContainer = $"MarginContainer/TabContainer/Board Settings"
@onready var highlight_houses: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox"
@onready var highlight_orthogonal: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox2"
@onready var highlight_same_value: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox3"
@onready var highlight_candidates: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox4"
@onready var double_digit_numbers: CheckBox = $"MarginContainer/TabContainer/Board Settings/CheckBox5"

func stylize_color_picker():
	var color_picker = color_picker_button.get_picker()
	color_picker.sampler_visible = false
	color_picker.color_modes_visible = false
	color_picker.sliders_visible = false
	color_picker.hex_visible = false
	color_picker.presets_visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stylize_color_picker()
	
	load_settings()
	save_settings()

	pass # Replace with function body.

func load_settings():
	
	if config.load("user://game_settings.cfg") != OK:
		save_settings()
	
	highlight_houses.button_pressed = config.get_value("board_settings", "highlight_houses")
	highlight_orthogonal.button_pressed = config.get_value("board_settings", "highlight_orthogonal")
	highlight_same_value.button_pressed = config.get_value("board_settings", "highlight_same_value")
	highlight_candidates.button_pressed = config.get_value("board_settings", "highlight_candidates")
	color_picker_button.color = config.get_value("board_settings", "highlight_color")
	double_digit_numbers.button_pressed = config.get_value("board_settings", "double_digit_numbers")
	update_game_settings()
	
func save_settings():
	config.set_value("board_settings", "highlight_houses", highlight_houses.button_pressed)
	config.set_value("board_settings", "highlight_orthogonal", highlight_orthogonal.button_pressed)
	config.set_value("board_settings", "highlight_same_value", highlight_same_value.button_pressed)
	config.set_value("board_settings", "highlight_candidates", highlight_candidates.button_pressed)
	config.set_value("board_settings", "highlight_color", color_picker_button.color)
	config.set_value("board_settings", "double_digit_numbers", double_digit_numbers.button_pressed)
	
	config.save("user://game_settings.cfg")
	
func update_game_settings():

	# TODO: convert double_digit_numbers to characters values / vice versa
	SELECTED.get_stylebox('normal', 'Button').bg_color = config.get_value("board_settings", "highlight_color")
	
