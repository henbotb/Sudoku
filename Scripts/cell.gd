extends Button
class_name Cell

var value: int
var is_locked: bool
var big_index: int
var small_index: int
var is_highlighted: bool
var candidates: GridContainer

const HIGHLIGHTED = preload("uid://be5h05f4havy0")
const DEFAULT = preload("uid://dqqaua4my3ejj")

# TESTING {
var rng = RandomNumberGenerator.new()
# }

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
	
	candidates = GridContainer.new()
	candidates.set_anchors_preset(Control.PRESET_FULL_RECT, false)
	candidates.add_theme_constant_override("h_separation", 0)
	candidates.add_theme_constant_override("v_separation", 0)
	candidates.layout_direction = Control.LAYOUT_DIRECTION_INHERITED
	

	add_child(candidates)
	
func initialize_candidates(cols: int, num_candidates: int):
	candidates.visible = true if value == -1 else false 
	candidates.columns = cols
	for i in range(num_candidates):
		var candidate_label = Label.new()
		# TESTING {
		candidate_label.text = "%d" % rng.randi_range(1, num_candidates) if rng.randf() > 0.5 else ""
		# }

		candidate_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL | Control.SIZE_SHRINK_CENTER
		candidate_label.size_flags_vertical = Control.SIZE_EXPAND_FILL | Control.SIZE_SHRINK_CENTER
		candidate_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		candidate_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		candidate_label.add_theme_font_size_override("font_size", 6)
		candidates.add_child(candidate_label)



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
		
