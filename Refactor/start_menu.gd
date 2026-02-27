extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_button_pressed() -> void:
	Settings.save()
	get_tree().quit()


func _on_multiplayer_button_pressed() -> void:
	pass # Replace with function body.

func _on_resume_game_button_pressed() -> void:
	pass # Replace with function body.

func _on_new_game_button_pressed() -> void:
	GameState.in_game = true
	pass # Replace with function body.
