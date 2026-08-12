extends Control
@onready var map_maker_menu: FoldableContainer = $"Map Maker Menu"
@onready var shapes: Node2D = $Map/Shapes
const Shape = preload("uid://b8sdcw5jj5ldo")

var currently_shaping : bool = false
var current_shape : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func point_pressed(coord : Vector2, state : bool):
	if currently_shaping:
		if current_shape.get_type()!=map_maker_menu.get_current_tool():
			current_shape.queue_free()
			currently_shaping=false
	
	if !currently_shaping :
		var new_shape = Shape.instantiate()
		shapes.add_child(new_shape)
		new_shape.set_type(map_maker_menu.get_current_tool())
		currently_shaping =true
		current_shape = new_shape

	if(current_shape.add_or_remove_point(coord*32,state)==1):
		currently_shaping=false
		current_shape= null
		
func point_hover(coord : Vector2, state : bool):
	if currently_shaping:
		if current_shape.get_type()!=map_maker_menu.get_current_tool():
			current_shape.queue_free()
			currently_shaping=false
		else:
			current_shape.preview_add_point(coord*32,state)
