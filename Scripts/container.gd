extends Container

const GRID_WIDTH = 9
const GRID_HEIGHT = 9
const HOUSE_WIDTH = 3
const HOUSE_HEIGHT = 3
const HOUSE_MAX = HOUSE_HEIGHT * HOUSE_WIDTH

@onready var container: Container = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for row in range(GRID_WIDTH):
		var row = HBoxContainer.new()
		
		for cell in range(GRID_HEIGHT):
			var cell = 
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
