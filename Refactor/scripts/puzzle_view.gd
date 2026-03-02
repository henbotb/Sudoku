extends Control

var board: BoardResource
var candidates: CandidateResource

var selected_cell := Vector2i(0, 0)

@onready var board_visual: GridContainer = $AspectRatioContainer/Board

func _initialize_board_data() -> void:
	board_visual.columns = board.NUM_BLOCK_COLS
	
	for y in range(board.board_array.size()):
		var block = board.board_array[y]
		
		var block_new = GridContainer.new()
		block_new.columns = board.NUM_COLUMNS_PER_BLOCK
		block_new.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		block_new.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		for x in range(block.size()):
			var cell = block[x]
			
			var cell_new = Button.new()
			cell_new.text = str(cell)
			cell_new.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			cell_new.size_flags_vertical = Control.SIZE_EXPAND_FILL
			
			cell_new.pressed.connect(_cell_pressed.bind(Vector2i(x, y)))

			block_new.add_child(cell_new)
				
		board_visual.add_child(block_new)


func _ready() -> void:
	_initialize_board_data()

func _cell_pressed(cell_pos: Vector2i) -> void:
	print(cell_pos)


# convert from string to this format
func _2d_to_block_index(cell_ndx: Vector2i) -> Vector2i:
	return Vector2i(cell_ndx.y, cell_ndx.x)
	
func _block_to_2d_index(cell_ndx: Vector2i) -> Vector2i:
	return Vector2i(cell_ndx.y, cell_ndx.x)
