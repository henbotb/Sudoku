extends Control

var settings_currently_displayed = false

@onready var puzzle: GridContainer = $Puzzle
@onready var label: Label = $Label
@onready var settings_menu: Control = $SettingsMenu
@onready var color_rect: ColorRect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = puzzle.get_cell_location()
	
func _input(ev):
	if Input.is_action_just_pressed("Settings"):
		if settings_currently_displayed:
			settings_menu.save_settings()
			settings_menu.update_game_settings()
		
		color_rect.visible = not settings_currently_displayed
		settings_menu.visible = not settings_currently_displayed
		puzzle.set_process_input(not settings_currently_displayed)
		settings_currently_displayed = not settings_currently_displayed
