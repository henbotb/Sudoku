extends GridContainer
class_name Board

enum DisplayMode {
	ALPHABETIC,
	DOUBLE_DIGIT,
}

# maybe migrate these to a singleton that candidates / cell can read from as well?
const BOARD_COLS = 9
const BOARD_ROWS = 9
const BIG_COLS = 3
const BIG_ROWS = 3
const NUM_HOUSES = BIG_COLS * BIG_ROWS
const HOUSE_COLS = BOARD_COLS / BIG_COLS
const HOUSE_ROWS = BOARD_ROWS / BIG_ROWS
const HOUSE_SIZE = HOUSE_COLS * HOUSE_ROWS

var display_mode: DisplayMode
var selected_cell: Cell = null
var config = Settings.config
var rng = RandomNumberGenerator.new()

# INITIALIZATION STUFF

func _ready() -> void:

	if initialize_board() != OK:
		printerr("Board didn't initialize correctly")
		
	display_mode = config.get_value("board_settings", "display_mode")
	render_board()
		
	
func initialize_board(board := []) -> Error:
	if board != []:
		# TODO: implement reading in other boards
		return ERR_BUG
		
	self.columns = BIG_COLS
	
	for house_ndx in range(NUM_HOUSES):
		# setup house
		# TODO: house borders / highlighting
		var house = GridContainer.new()
		house.columns = HOUSE_COLS
		house.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		house.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		for cell_ndx in range(HOUSE_SIZE):
			# setup button
			var cell = Cell.new(house_ndx, cell_ndx, rng.randi_range(1, HOUSE_SIZE) if rng.randf() > 0.5 else -1)
			
			# connect to function for recognition
			cell.button_up.connect(cell_pressed.bind(cell))
			
			cell.initialize_candidates(HOUSE_COLS, HOUSE_SIZE)
				
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
	
	if (
		selected_cell == null 
		or (selected_cell.value == -1 and not config.get_value("board_settings", "highlight_empty_cells"))
	):
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
	if(value == -1):
		return
	get_tree().call_group(str(value), "highlight")

func render_board():
	var cells: Array[Node] = get_tree().get_nodes_in_group("cell")

	for cell in cells:
		cell.render()

func _input(event):

	if event is InputEventKey and event.pressed:
		print("Getting here 0")
		if selected_cell == null:
			return
		print("Getting here 1")
		
		if selected_cell.is_locked:
			return
		print("Getting here 2")
		
		if event.is_action_pressed("delete"):
			if selected_cell.value != -1:
				selected_cell.value = -1
			else:
				selected_cell.clear_candidates()
				
		print("Getting here 4")
		

		if event.is_action_pressed("backspace"):
			if selected_cell.value == -1:
				return
			
			if display_mode == DisplayMode.ALPHABETIC:
				selected_cell.value = -1
			else:
				if 0 < selected_cell.value and selected_cell.value < 10:
					selected_cell.value = -1
				else:
					selected_cell.value = (selected_cell.value - (selected_cell.value % 10)) / 10

		print("Getting here 5")
		
		if display_mode == DisplayMode.ALPHABETIC:
			print(selected_cell.value)
			print("Key A:", KEY_A, "Input:", event.keycode)
			if KEY_1 <= event.keycode and event.keycode <= KEY_9:
				print("Reaching here")
				selected_cell.value = event.keycode - KEY_0 #
			elif KEY_A <= event.keycode and event.keycode < KEY_A - 9 + HOUSE_SIZE:
				print("Reaching here 2")
				selected_cell.value = event.keycode - KEY_A + 10
				
				
		else:
			if KEY_0 <= event.keycode and event.keycode <= KEY_9:
				if selected_cell.value == -1 && event.keycode != KEY_0:
					selected_cell.value = event.keycode - KEY_0
					
				elif (
					0 < selected_cell.value * 10 + event.keycode - KEY_0
					and selected_cell.value * 10 + event.keycode - KEY_0 <= HOUSE_SIZE
				) :
					selected_cell.value = selected_cell.value * 10 + event.keycode - KEY_0
		
		selected_cell.render()
		highlight()


# HELPER FUNCTION STUFF

func get_row(big_index: int, small_index: int) -> Array[Cell]:
	var row: Array[Cell] = []
	
	for outer_ndx in range((big_index / BIG_COLS) * BIG_COLS, ((big_index / BIG_COLS) + 1) * BIG_COLS):
		for inner_ndx in range((small_index / HOUSE_COLS) * HOUSE_COLS, ((small_index / HOUSE_COLS) + 1) * HOUSE_COLS):
			row.append(get_child(outer_ndx).get_child(inner_ndx))
	
	return row

func get_column(big_index: int, small_index: int) -> Array[Cell]:
	var column: Array[Cell] = []
	
	for outer_ndx in range(big_index % BIG_COLS, NUM_HOUSES, BIG_COLS):
		for inner_ndx in range(small_index % HOUSE_COLS, HOUSE_SIZE, HOUSE_COLS):
			column.append(get_child(outer_ndx).get_child(inner_ndx))
	
	return column
	

func update_settings():
	
	var display_mode_new = config.get_value("board_settings", "display_mode")
	if display_mode != display_mode_new:
		display_mode = display_mode_new
		render_board()
