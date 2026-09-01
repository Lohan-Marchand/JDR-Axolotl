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

func change_tool():
	if currently_shaping:
		if current_shape.get_type()!=map_maker_menu.get_current_tool():
			current_shape.toggle_points(false)
			current_shape.queue_free()
			currently_shaping=false

func point_left_pressed(point : Node):
	if map_maker_menu.get_current_categorie() == "wall":
		build_wall(point)

func point_right_pressed(point : Node):
	if map_maker_menu.get_current_categorie() == "wall" && map_maker_menu.get_current_tool() == "free" :
		close_wall(point)

func point_hover(point : Node, state : bool):
	if map_maker_menu.get_current_categorie() == "wall":
		hover_wall(point, state)



func build_wall(point : Node):
	if !currently_shaping :
		var new_shape = Shape.instantiate()
		shapes.add_child(new_shape)
		new_shape.set_type(map_maker_menu.get_current_tool())
		currently_shaping =true
		current_shape = new_shape
	
	var result = current_shape.add_or_remove_point(point)
	if(result==1):
		currently_shaping=false
		current_shape.remove_preview()
		current_shape= null
	else:if(result==-1):
		
		currently_shaping=false
		current_shape.queue_free()
		current_shape= null

func hover_wall(point : Node,state :bool):
	if currently_shaping:
		current_shape.preview_add_point(point,state)

func close_wall(point : Node):
	if currently_shaping:
		current_shape.close_free(point)
		currently_shaping=false
		current_shape.remove_preview()
		current_shape= null
