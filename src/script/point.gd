extends Node2D
@onready var button: Button = $Button
var toggle_state :bool =false
var toggled_on :StyleBoxFlat
var toggled_off :StyleBoxFlat
var hover_on : StyleBoxFlat
var hover_off : StyleBoxFlat
var _coord : Vector2

func set_coord(coord : Vector2):
	_coord = coord
	self.global_position=coord*32

func _ready() -> void:
	toggled_on = button.get_theme_stylebox("pressed")
	toggled_off = button.get_theme_stylebox("normal")
	hover_on = button.get_theme_stylebox("hover")
	hover_off = button.get_theme_stylebox("hover_mirrored")

	
func _process(delta: float) -> void:
	pass

func toggle(state : bool):
	toggle_state = state
	if toggle_state:
		button.add_theme_stylebox_override("normal",toggled_on)
		button.add_theme_stylebox_override("pressed",toggled_off)
		button.add_theme_stylebox_override("hover",hover_off)
	else:
		button.add_theme_stylebox_override("normal",toggled_off)
		button.add_theme_stylebox_override("pressed",toggled_on)
		button.add_theme_stylebox_override("hover",hover_on)

func get_toggle_state():
	return toggle_state

func get_coord():
	return _coord
