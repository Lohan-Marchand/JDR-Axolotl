extends Node2D
@onready var line_2d: Line2D = $Line2D
@onready var preview_line_2d: Line2D = $PreviewLine2D

var _type : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_type(type : String):
	_type= type

func get_type():
	return _type

func add_or_remove_point(coord : Vector2, state : bool):
	match _type:
		"":
			return 1
		"Ligne":
			if state:
				line_2d.add_point(coord)
			else:
				line_2d.remove_point(line_2d.points.rfind(coord))
			
			if line_2d.get_point_count()==2:
				return 1
		"Rectangle":
			if state:
				if line_2d.get_point_count()==0:
					line_2d.add_point(coord)
				else:
					line_2d.add_point(Vector2(coord.x,line_2d.get_point_position(0).y))
					line_2d.add_point(coord)
					line_2d.add_point(Vector2(line_2d.get_point_position(0).x,coord.y))
					line_2d.add_point(line_2d.get_point_position(0))
			else:
				line_2d.remove_point(line_2d.points.rfind(coord))
			
			if line_2d.get_point_count()==5:
				return 1
		"Free":
			if state:
				line_2d.add_point(coord)
			else:
				line_2d.remove_point(line_2d.points.rfind(coord))

func preview_add_point(coord : Vector2, state : bool):
	preview_line_2d.add_point(line_2d.get_point_position(line_2d.get_point_count()-1))
	match _type:
		"":
			return 1
		"Ligne":
			if state:
				preview_line_2d.add_point(coord)
			else:
				preview_line_2d.remove_point(preview_line_2d.points.rfind(coord))
		"Rectangle":
			if state:
				if preview_line_2d.get_point_count()==0:
					preview_line_2d.add_point(coord)
				else:
					preview_line_2d.add_point(Vector2(coord.x,preview_line_2d.get_point_position(0).y))
					preview_line_2d.add_point(coord)
					preview_line_2d.add_point(Vector2(preview_line_2d.get_point_position(0).x,coord.y))
					preview_line_2d.add_point(preview_line_2d.get_point_position(0))
			else:
				preview_line_2d.remove_point(preview_line_2d.points.rfind(Vector2(coord.x,preview_line_2d.get_point_position(0).y)))
				preview_line_2d.remove_point(preview_line_2d.points.rfind(coord))
				preview_line_2d.remove_point(preview_line_2d.points.rfind(Vector2(preview_line_2d.get_point_position(0).x,coord.y)))
				preview_line_2d.remove_point(0)
		"Free":
			if state:
				preview_line_2d.add_point(coord)
			else:
				preview_line_2d.remove_point(preview_line_2d.points.rfind(coord))
