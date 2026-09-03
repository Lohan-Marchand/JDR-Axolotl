extends Node2D
@onready var line_2d: Line2D = $Line2D
@onready var preview_line_2d: Line2D = $PreviewLine2D
var _type : String
var _tab_point : Array[Node]
var _grid: Node2D
var _map : Node2D
var _texture : String
var _shaders : ShaderMaterial


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_grid = get_parent().get_parent().get_child(2)
	_map = get_parent().get_parent()
	_shaders = line_2d.material
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_shaders.set_shader_parameter("scale",_map.scale.x)
	pass

func change_texture(texture_path : String,texture_size : int):
	_texture = texture_path
	_shaders.set_shader_parameter("texture",load("res://assets/tiles/"+_texture))
	_shaders.set_shader_parameter("tile_size",texture_size)

func set_type(type : String):
	_type= type

func get_type():
	return _type

func add_or_remove_point(point : Node):
	match _type:
		"":
			toggle_points(false)
			return 1
		"line":
			if !point.get_toggle_state():
				add_point(point)
			else:
				remove_point(point)
			
			if line_2d.get_point_count()==2:
				toggle_points(false)
				return 1
		"rectangle":
			line_2d.closed=true
			if !point.get_toggle_state():
				if line_2d.get_point_count()==0:
					add_point(point)
				else:
					add_point(_grid.get_point(Vector2(point.get_coord().x,_tab_point.get(0).get_coord().y)))
					add_point(point)
					add_point(_grid.get_point(Vector2(_tab_point.get(0).get_coord().x,point.get_coord().y)))
					toggle_points(false)
					return 1
			else:
				remove_point(point)
		"free":
			if !point.get_toggle_state():
				add_point(point)
			else:
				remove_point(point)
	if line_2d.get_point_count()==0:
		return -1

func close_free(point : Node):
	if point == _tab_point.get(0):
		line_2d.closed=true
	else:if point !=_tab_point.get(_tab_point.size()-1):
		add_point(point)
	toggle_points(false)
	

func add_point(point : Node):
	point.toggle(true)
	line_2d.add_point(point.get_coord()*32)
	_tab_point.push_back(point)
	

func remove_point(point : Node):
	point.toggle(false)
	var point_to_remove : int =_tab_point.find(point)
	line_2d.remove_point(point_to_remove)
	_tab_point.remove_at(point_to_remove)

func preview_add_point(point : Node, state : bool):
	if state:
		preview_line_2d.add_point(line_2d.get_point_position(line_2d.get_point_count()-1))
	else:
		preview_line_2d.remove_point(0)
	match _type:
		"":
			return 1
		"line":
			if state:
				preview_line_2d.add_point(point.get_coord()*32)
			else:
				preview_line_2d.remove_point(preview_line_2d.points.rfind(point.get_coord()*32))
		"rectangle":
			if state:
				if preview_line_2d.get_point_count()==0:
					preview_line_2d.add_point(point.get_coord()*32)
				else:
					preview_line_2d.add_point(Vector2(point.get_coord().x*32,preview_line_2d.get_point_position(0).y))
					preview_line_2d.add_point(point.get_coord()*32)
					preview_line_2d.add_point(Vector2(preview_line_2d.get_point_position(0).x,point.get_coord().y*32))
					preview_line_2d.add_point(preview_line_2d.get_point_position(0))
			else:
				preview_line_2d.remove_point(preview_line_2d.points.rfind(Vector2(point.get_coord().x*32,preview_line_2d.get_point_position(0).y)))
				preview_line_2d.remove_point(preview_line_2d.points.rfind(point.get_coord()*32))
				preview_line_2d.remove_point(preview_line_2d.points.rfind(Vector2(preview_line_2d.get_point_position(0).x,point.get_coord().y*32)))
				preview_line_2d.remove_point(0)
		"free":
			if state:
				preview_line_2d.add_point(point.get_coord()*32)
			else:
				preview_line_2d.remove_point(preview_line_2d.points.rfind(point.get_coord()*32))

func toggle_points(state : bool):
	for point in _tab_point :
		point.toggle(state)

func remove_preview():
	preview_line_2d.clear_points()
