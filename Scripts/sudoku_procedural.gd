extends GridContainer

const BOARD_COLS = 9
const BOARD_ROWS = 9

const BIG_COLS = 3
const BIG_ROWS = 3

@warning_ignore("integer_division")
const HOUSE_COLS = BOARD_COLS / BIG_COLS
@warning_ignore("integer_division")
const HOUSE_ROWS = BOARD_ROWS / BIG_ROWS

var SELECTED = preload("uid://be5h05f4havy0")
var DEFAULT = preload("uid://dqqaua4my3ejj")

var config = ConfigFile.new()
var selected_cell: Button

@onready var puzzle: GridContainer = $"."




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if config.load("user://game_settings.cfg") != OK:
		printerr("User didn't have a game_settings file")
	
	if create_board() != OK:
		printerr("Board/Inner Rows/Cols initialized to non-divisible value")
		
	#SELECTED.default_font_size = 10
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func create_board() -> Error:
	if BOARD_COLS % BIG_COLS != 0 or BOARD_ROWS % BIG_ROWS != 0:
		return 	ERR_PARAMETER_RANGE_ERROR
		
	puzzle.columns = BIG_COLS
	
	for house_ndx in range(BIG_COLS * BIG_ROWS):
		# setup house
		var house = GridContainer.new()
		house.columns = HOUSE_COLS
		house.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		house.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		for cell_ndx in range(HOUSE_COLS * HOUSE_ROWS):
			# setup button
			var btn = Button.new()
			btn.text = "%d" % (cell_ndx + 1)
			btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
			
			# connect to function for recognition
			btn.button_up.connect(cell_pressed.bind(house_ndx, cell_ndx, btn))
			
			# add to house
			house.add_child(btn)
			
		# add to puzzle		
		puzzle.add_child(house)
		
	return OK

func highlight_similar() -> void:
	reset_highlights()
	
	if selected_cell == null or selected_cell.text == "":
		return
		
	selected_cell.theme = SELECTED
	
	# house
	if config.get_value("board_settings", "highlight_houses") or 1:
		highlight_house(selected_cell.get_parent())
	
	# row / column
	if config.get_value("board_settings", "highlight_orthogonal") or 1:
		highlight_orthogonal(selected_cell.get_parent().get_index(), selected_cell.get_index())
	
	# same number
	if config.get_value("board_settings", "highlight_same_value") or 1:
		highlight_same_value(int(selected_cell.text))
	
	# candidates
	#if config.get_value("board_settings", "highlight_candidates"):
		#highlight_candidates(int(cell.text))
		
func highlight_house(house: GridContainer) -> void:
	var cells: Array[Node] = house.get_children()
	for cell in cells:
		cell.theme = SELECTED
	
func highlight_orthogonal(big_ndx: int, small_ndx: int) -> void:
	var to_highlight: Array[Button]
	
	# column
	for outer_ndx in range(big_ndx % BIG_COLS, BIG_ROWS * BIG_COLS, BIG_COLS):
		for inner_ndx in range(small_ndx % HOUSE_COLS, HOUSE_ROWS * HOUSE_COLS, HOUSE_COLS):
			to_highlight.append(puzzle.get_child(outer_ndx).get_child(inner_ndx))

	# row
	@warning_ignore("integer_division")
	for outer_ndx in range((big_ndx / BIG_COLS) * BIG_COLS, ((big_ndx / BIG_COLS) + 1) * BIG_COLS):
		@warning_ignore("integer_division")
		for inner_ndx in range((small_ndx / HOUSE_COLS) * HOUSE_COLS, ((small_ndx / HOUSE_COLS) + 1) * HOUSE_COLS):
			to_highlight.append(puzzle.get_child(outer_ndx).get_child(inner_ndx))
			
	for cell in to_highlight:
		cell.theme = SELECTED
	
	
func highlight_same_value(cell_number: int) -> void:
	var houses: Array[Node] = puzzle.get_children()
	for house in houses:
		var cells: Array[Node] = house.get_children()
		for cell in cells:
			if(int(cell.text) == cell_number):
				cell.theme = SELECTED

# TODO: 
#func highlight_candidates(cell_number: int):
	#pass

func reset_highlights() -> void:
	var houses: Array[Node] = puzzle.get_children()
	for house in houses:
		var cells: Array[Node] = house.get_children()
		for cell in cells:
			cell.theme = DEFAULT

func cell_pressed(big_ndx: int, small_ndx: int, cell: Button) -> void:
	selected_cell = cell
	highlight_similar()
	
	print("Big index: %d Small index: %d Value: %s" % [big_ndx, small_ndx, cell.text])
	
func get_cell_location() -> String:
	return ("B: %d, S: %d" % [get_global_mouse_position().x, get_global_mouse_position().y])

	
