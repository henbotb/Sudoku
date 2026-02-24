extends Control

@onready var button: Button = $Button
@onready var color_rect: ColorRect = $ColorRect
@onready var text_edit: TextEdit = $ColorRect/TextEdit

func _on_button_generate_button_up() -> void:
	GameState.puzzle_base_board = text_edit.text
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_button_copy_button_up() -> void:
	GameState.puzzle_base_board = DisplayServer.clipboard_get()
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_button_start_button_up() -> void:
	color_rect.visible = true
	
func _on_button_quit_button_up() -> void:
	get_tree().quit()
	

func _input(event):
	if event.is_action(&"settings"):
		color_rect.visible = false
