extends GridContainer
class_name Board

enum DisplayMode {
	DOUBLE_DIGIT,
	ALPHABETIC,
}

const BOARD_COLS = 9
const BOARD_ROWS = 9
const BIG_COLS = 3
const BIG_ROWS = 3
const HOUSE_COLS = BOARD_COLS / BIG_COLS
const HOUSE_ROWS = BOARD_ROWS / BIG_ROWS

var selected_cell: Cell = null
var config = ConfigFile.new()
var rng = RandomNumberGenerator.new()

# INITIALIZATION STUFF

func _ready() -> void:
	if config.load("user://game_settings.cfg") != OK:
		printerr("User didn't have a game_settings file")
		
	if initialize_board() != OK:
		printerr("Board didn't initialize correctly")
		
	render_board()
		
	
func initialize_board(board := []) -> Error:
	if board != []:
		# TODO: implement reading in other boards
		return ERR_BUG
		
	self.columns = BIG_COLS
	
	for house_ndx in range(BIG_COLS * BIG_ROWS):
		# setup house
		var house = GridContainer.new()
		house.columns = HOUSE_COLS
		house.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		house.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		for cell_ndx in range(HOUSE_COLS * HOUSE_ROWS):
			# setup button
			var cell = Cell.new(house_ndx, cell_ndx, rng.randi_range(1, 9))
			
			# connect to function for recognition
			cell.button_up.connect(cell_pressed.bind(cell))
			
			# add to house
			house.add_child(cell)
			
		# add to puzzle		
		self.add_child(house)
	
	return OK
	
func cell_pressed(cell: Cell) -> void:
	selected_cell = cell
	highlight()
	
# HIGHLIGHTING STUFF

func highlight():
	reset_highlights()
	
	if selected_cell == null or selected_cell.value == -1:
		return
		
	selected_cell.highlight()
	
	# house
	if config.get_value("board_settings", "highlight_houses"):
		highlight_house(selected_cell.get_parent())
	
	# row / column
	if config.get_value("board_settings", "highlight_orthogonal"):
		highlight_orthogonal(selected_cell.big_index, selected_cell.small_index)
	
	# same number
	if config.get_value("board_settings", "highlight_same_value"):
		highlight_same_value(selected_cell.value)
	
	# TODO: candidates
	#if config.get_value("board_settings", "highlight_candidates"):
		#highlight_candidates(int(cell.text))

func reset_highlights():
	get_tree().call_group("highlighted", "unhighlight")
	
func highlight_house(house: GridContainer):
	for cell in house.get_children():
		cell.highlight()
	
func highlight_orthogonal(big_index: int, small_index: int):
	var to_highlight = get_row(big_index, small_index) + get_column(big_index, small_index)
	for cell in to_highlight:
		cell.highlight()
	
func highlight_same_value(value: int):
	get_tree().call_group(str(value), "highlight")
	
# TODO: func render_board():

func render_board():
	var is_double_digit: bool = config.get_value("board_settings", "double_digit_numbers")
	var cells: Array[Node] = get_tree().get_nodes_in_group("cell")

	for cell in cells:
		if is_double_digit:
			cell.text = str(cell.value)
		else:
			cell.text = convert_value_to_char(cell.value)

# HELPER FUNCTION STUFF

func get_row(big_index: int, small_index: int) -> Array[Cell]:
	var row: Array[Cell] = []
	
	for outer_ndx in range((big_index / BIG_COLS) * BIG_COLS, ((big_index / BIG_COLS) + 1) * BIG_COLS):
		for inner_ndx in range((small_index / HOUSE_COLS) * HOUSE_COLS, ((small_index / HOUSE_COLS) + 1) * HOUSE_COLS):
			row.append(get_child(outer_ndx).get_child(inner_ndx))
	
	return row

func get_column(big_index: int, small_index: int) -> Array[Cell]:
	var column: Array[Cell] = []
	
	for outer_ndx in range(big_index % BIG_COLS, BIG_ROWS * BIG_COLS, BIG_COLS):
		for inner_ndx in range(small_index % HOUSE_COLS, HOUSE_ROWS * HOUSE_COLS, HOUSE_COLS):
			column.append(get_child(outer_ndx).get_child(inner_ndx))
	
	return column
	
func convert_value_to_char(value: int) -> String:
	if 0 < value and value < 10:
		return str(value)
	return char(value + 87)
