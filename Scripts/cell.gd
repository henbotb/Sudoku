extends Button
class_name Cell

var value: int
var is_locked: bool
var big_index: int
var small_index: int
var is_highlighted: bool

const HIGHLIGHTED = preload("uid://be5h05f4havy0")
const DEFAULT = preload("uid://dqqaua4my3ejj")

func _init(big_ndx: int, small_ndx, val := -1, highlighted := false, is_lock := false):
	big_index = big_ndx
	small_index = small_ndx
	value = val
	is_highlighted = highlighted
	is_locked = is_lock
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	add_to_group(str(val))
	add_to_group("cell")

func highlight():
	if not is_highlighted:
		self.theme = HIGHLIGHTED
		is_highlighted = true
		add_to_group("highlighted")
		
func unhighlight():
	if is_highlighted:
		self.theme = DEFAULT
		is_highlighted = false
		remove_from_group("highlighted")
		
