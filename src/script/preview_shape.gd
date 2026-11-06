extends Line2D
func set_rectangle(last_point : Node,point: Node):
	add_point(last_point.get_coord()*32)
	add_point((Vector2(point.get_coord().x,last_point.get_coord().y))*32)
	add_point(point.get_coord()*32)
	add_point((Vector2(last_point.get_coord().x,point.get_coord().y))*32)
	
func set_line(last_point : Node,point : Node):
		add_point(last_point.get_coord()*32)
		add_point(point.get_coord()*32)
