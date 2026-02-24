extends Node

enum MarkingMode {
	ADD,
	CELL_CANDIDATE,
	# TODO: COLOR
	# TODO: BLOCK_CANDIDATE
}

static var marking_mode := MarkingMode.ADD
var puzzle_base_board = ""

# TODO: move col_num, etc. here(?)
func _init():
	pass
