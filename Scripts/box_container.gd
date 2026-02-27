extends BoxContainer

const CELLS_Y = 9
const CELLS_X = 9
const HOUSE_CELLS_X = 3
const HOUSE_CELLS_Y = 3
@warning_ignore("integer_division")
const NUM_HOUSES_X = CELLS_X / HOUSE_CELLS_X
@warning_ignore("integer_division")
const NUM_HOUSES_Y = CELLS_Y / HOUSE_CELLS_Y
const CELLS_PER_HOUSE = HOUSE_CELLS_X * HOUSE_CELLS_Y


@onready var box_container: BoxContainer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
	
	
#func _populate_grid() -> void:
	#for houses_x in range(NUM_HOUSES_X):
		#var row = VBoxContainer.new()
		#box_container.add_child(row)
		#
		#for houses_y in range(NUM_HOUSES_Y):
			#var row_internal = VBoxContainer.new()
			#row.add_child(row_internal)
			#
			#for cells_x in range(HOUSE_CELLS_X):
				#row_internal.add_child()
		
	
