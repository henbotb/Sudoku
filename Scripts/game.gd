extends Control

var settings_currently_displayed = false

@onready var board: Board = $Board
@onready var settings_menu: Control = $SettingsMenu
@onready var color_rect: ColorRect = $ColorRect

func _input(_ev):
	if Input.is_action_just_pressed("settings"):
		color_rect.visible = not settings_currently_displayed
		settings_menu.visible = not settings_currently_displayed
		board.set_block_signals(not settings_currently_displayed)	
		settings_currently_displayed = not settings_currently_displayed
		
		settings_menu.save_settings()
		settings_menu.update_game_settings()
		board.update_settings()
