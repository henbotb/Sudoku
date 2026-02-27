extends Resource

var BOARD_COLS: int
var BOARD_ROWS: int
var BIG_COLS: int
var BIG_ROWS: int
var NUM_CELLS = BOARD_COLS * BOARD_ROWS
var NUM_BLOCKS = BIG_COLS * BIG_ROWS
var BLOCK_COLS = BOARD_COLS / BIG_COLS
var BLOCK_ROWS = BOARD_ROWS / BIG_ROWS
var BLOCK_SIZE = BLOCK_COLS * BLOCK_ROWS

var board_array: Array = []

# unsure: string in format: #...# (1-9, a-whatever)
var board_string: String = ""

func _init(board_str: String = "") -> void:
	board_string = board_str


func _ready() -> void:
	if board_string == "":
		return
	
	for y in range(BOARD_ROWS):
		var row: Array[int] = []
		for x in range(BOARD_COLS):
			# TODO: Add string read-in
			row.append(0)
		board_array.append(row)
		
