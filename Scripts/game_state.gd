extends Node
class_name GameState

enum MarkingMode {
	ADD,
	CELL_CANDIDATE,
	# TODO: COLOR
	# TODO: BLOCK_CANDIDATE
}

static var marking_mode := MarkingMode.ADD

# TODO: move col_num, etc. here(?)
func _init():
	pass
