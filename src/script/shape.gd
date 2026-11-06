extends Node2D

class Line:
	var point_a : Node
	var point_b : Node
	func _init(a:Node,b:Node):
		set_point_a(a)
		set_point_b(b)
	func set_point_a(a : Node):
		point_a = a
	func set_point_b(b : Node):
		point_b = b
	func get_point_a():
		return point_a
	func get_point_b():
		return point_b

@onready var line_2d: Line2D = $Line2D
@onready var preview_line_2d: Line2D = $PreviewShape
@onready var map_maker: Control = $"../../.."
@onready var shapes: Node2D = $".."
var grid: Node2D
var map : Node2D

var texture : String
var shaders : ShaderMaterial

#var closed :bool =false
var tab_line : Array[Line]
var last_point : Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid = get_parent().get_child(0)
	map = get_parent().get_parent()
	shaders = line_2d.material
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shaders.set_shader_parameter("scale",map.scale.x)
	pass

func change_texture(texture_path : String,texture_size : int):
	texture = texture_path
	shaders.set_shader_parameter("texture",load("res://assets/tiles/"+texture))
	shaders.set_shader_parameter("tile_size",texture_size)

func get_first_point():
	if (tab_line.size()>0):
		return tab_line[0].get_point_a()
	else:
		return last_point

func get_last_line_with(point : Node):# cherche la dernière ligne commencant par le point passé en param ;-1 signifie que le point est le dernier point, -2 signifie que le point n'est pas dans le tableau
	if(last_point==point):
		return -1
	for n in range (tab_line.size()-1,-1,-1):
		if (tab_line[n].get_point_a()==point):
			return n
	return -2

func has_point(point : Node):
	if(last_point==point):
		return true
	for n in range (tab_line.size()-1,-1,-1):
		if (tab_line[n].get_point_a()==point):
			return true
	return false

func point_left_click(tool,point: Node):
	match tool:
		map_maker.Tool.LINE:
			#closed=false
			add_point_at_end(point)
			if tab_line.size()==1:
				point_hover(tool,point,false)
				done()
		map_maker.Tool.RECTANGLE:
			#closed=true
			add_point_rectangle(point)
			if tab_line.size()==4:
				point_hover(tool,point,false)
				done()
		map_maker.Tool.FREE:
			if(!tab_line.is_empty() && point == last_point):
				done()
			else:
				add_point_at_end(point)
	point_hover(tool,point,false)
	
func point_right_click(tool,point: Node):
	match tool:
		map_maker.Tool.LINE:
			remove_point(point)
		map_maker.Tool.RECTANGLE:
			remove_point(point)
			if tab_line.size()==4:
				done()
		map_maker.Tool.FREE:
			remove_point(point)

func point_hover(tool,point : Node,state : bool):
	if(last_point==null):
		return
	match tool:
		map_maker.Tool.LINE:
			if(state):
				preview_line_2d.set_line(last_point,point)
			else:
				preview_line_2d.clear_points()
		map_maker.Tool.RECTANGLE:
			if(state):
				preview_line_2d.set_rectangle(last_point,point)
			else:
				preview_line_2d.clear_points()

		map_maker.Tool.FREE:
			if(state):
				preview_line_2d.set_line(last_point,point)
			else:
				preview_line_2d.clear_points()

func add_point_rectangle(point : Node):
	if (last_point==null):
		last_point=point
	else:
		add_point_at_end(grid.get_point(Vector2(point.get_coord().x,get_first_point().get_coord().y)))
		add_point_at_end(point)
		add_point_at_end(grid.get_point(Vector2(get_first_point().get_coord().x,point.get_coord().y)))
		add_point_at_end(get_first_point())
		calculate_shape()

func add_point_at_end(point : Node):
	point.toggle(true)
	if(last_point==null):
		last_point=point
	else:
		tab_line.push_back(Line.new(last_point,point))
		last_point=point
	calculate_shape()

func remove_point(point : Node):
	if (point.get_toggle_state()):
		var n = get_last_line_with(point)
		if(n==-1):
			var line_removed = tab_line.pop_back()
			if(line_removed==null):
				last_point=null
			else:
				last_point=line_removed.get_point_a()
		elif(n==0):
			tab_line.pop_front()
		else:
			var line_removed = tab_line.pop_at(n)
			tab_line[n-1].set_point_b(line_removed.get_point_b())
		if (!has_point(point)):
			point.toggle(false)
		calculate_shape()

func calculate_shape():
	if (last_point!=null):
		line_2d.clear_points()
		line_2d.add_point(get_first_point().get_coord()*32)
		for n in range (0,tab_line.size(),1):
			line_2d.add_point(tab_line[n].get_point_b().get_coord()*32)

func done():
	toggle_points(false)
	shapes.unselect_shape()

func toggle_points(state : bool):
	if (last_point!=null):
		last_point.toggle(state)
		for n in range (tab_line.size()-1,-1,-1):
			tab_line[n].get_point_a().toggle(state)
