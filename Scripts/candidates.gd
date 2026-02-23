extends GridContainer
class_name Candidates

const HIGHLIGHTED = preload("uid://be5h05f4havy0")
const DEFAULT = preload("uid://dqqaua4my3ejj")

var candidate_values: Array[bool] = []
var num_candidates: int

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT, true)
	add_theme_constant_override("h_separation", 0)
	add_theme_constant_override("v_separation", 0)
	
	add_to_group("candidates")

	# maybe migrate candidates to cells ?
func initialize_candidates(cols: int, house_size: int):
	columns = cols
	num_candidates = house_size
	for candidate_index in range(num_candidates):
		candidate_values.append(true)

		var candidate_label = Label.new()
		# TESTING {
		# }

		candidate_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL | Control.SIZE_SHRINK_CENTER
		candidate_label.size_flags_vertical = Control.SIZE_EXPAND_FILL | Control.SIZE_SHRINK_CENTER
		candidate_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		candidate_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		candidate_label.add_theme_font_size_override("font_size", 12)
		add_child(candidate_label)
		add_candidate(candidate_index + 1)
		
func add_candidate(value: int):
	print("Value passed: %d" % value)
	if value < 1 or value > num_candidates:
		return
	candidate_values[value - 1] = true
	print("Value: %d" % value)
	get_child(value - 1).text = str(value) if Settings.config.get_value("board_settings", "display_mode") == 0 else Cell.get_display_value(value)
	
func remove_candidate(value: int):
	if 0 < value or value > num_candidates:
		return
	candidate_values[value - 1] = false
	get_child(value - 1).text = ""
