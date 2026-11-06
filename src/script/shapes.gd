extends Node2D
@onready var map_maker: Control = $"../.."
const Shape = preload("uid://b8sdcw5jj5ldo")

var currently_shaping : bool = false
var current_shape : Node
var current_tool

func change_tool(tool):
	if(current_tool!=tool):
		if(currently_shaping):
			current_shape.toggle_points(false)
			current_shape.queue_free()
			unselect_shape()
		current_tool=tool

func point_left_pressed(point : Node):
	if(!currently_shaping):
		match current_tool:
			map_maker.Tool.LINE:
				new_wall(point)
			map_maker.Tool.RECTANGLE:
				new_wall(point)
			map_maker.Tool.FREE:
				new_wall(point)
			# ^^^ si on créé un mur ^^^
	else:
		current_shape.point_left_click(current_tool,point)

func point_right_pressed(point : Node):
	if(currently_shaping):
		current_shape.point_right_click(current_tool,point)

func point_hover(point : Node, state : bool):
	if(currently_shaping):
		current_shape.point_hover(current_tool,point,state)

func new_wall(point : Node):
		var new_shape = Shape.instantiate()
		add_child(new_shape)
		currently_shaping =true
		current_shape = new_shape
		current_shape.point_left_click(current_tool,point)

func unselect_shape():
	current_shape=null
	currently_shaping=false
