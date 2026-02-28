extends Control

# TODO: saving system for game current state, probably managed NOT here
@onready var confirm_quit_panel: Panel = $ConfirmQuitPanel
@onready var settings: Control = $Settings
@onready var multiplayer_panel: Panel = $MultiplayerPanel
@onready var code_line_edit: LineEdit = $MultiplayerPanel/MarginContainer/VBoxContainer2/VBoxContainer3/HBoxContainer/CodeLineEdit

func copy_code():
	# TODO: generate code when copy code is clicked or something? 
	# not sure when the best place to actually do this is
	# maybe it makes sense to have another button for generating the code in the first place
	DisplayServer.clipboard_set(code_line_edit.text)

func toggle_code_displayed():
	code_line_edit.secret = not code_line_edit.secret

func display_pause_menu(on: bool):
	visible = on

func display_confirm_quit(on: bool):
	confirm_quit_panel.visible = on
	
func display_multiplayer(on: bool):
	multiplayer_panel.visible = on

func confirm_quit():
	# TODO: some save function of some kind
	get_tree().change_scene_to_file("res://Refactor/start_menu.tscn")

func _input(event: InputEvent):
	if event.is_action_pressed(&"settings"):
		print("checkpoint 1")
		
		if not visible:
			print("caught by not visible -> visible")
			display_pause_menu(true)
			return
		
		if confirm_quit_panel.visible or multiplayer_panel.visible:
			print("caught by not sub_panels visible -> sub_panels not visible")
			display_confirm_quit(false)
			display_multiplayer(false)
			# settings handles itself, including in the if criteria so it doesn't close pause menu buttons
			# TODO: fix bug with closing out of settings closing all "windows"
			return
		
		print("checkpoint 3")
		if visible:
			print("caught by visible -> not visible")
			display_pause_menu(false)
			return
			
		print("checkpoint 4")
		
