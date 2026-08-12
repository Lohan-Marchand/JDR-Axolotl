extends Node2D

var _size= Vector2(25,50)
const Point = preload("uid://br8nuh81uqati")
var tab_point : Dictionary[Vector2, Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_grid(_size)
	pass # Replace with function body.

func generate_grid(size : Vector2 ):
	for x in size.x:
		for y in size.y:
			var new_point = Point.instantiate()
			var new_button : Button = new_point.get_child(0)
			
			new_button.pressed.connect(func point_pressed():
				get_parent().get_parent().point_pressed(Vector2(x,y),new_point.get_toggle_state())
			)
			new_button.mouse_entered.connect(func point_hover_in():
				get_parent().get_parent().point_hover(Vector2(x,y),true)
			)
			new_button.mouse_exited.connect(func point_hover_out():
				get_parent().get_parent().point_hover(Vector2(x,y),false)
			)
			
			tab_point.set(Vector2(x,y),new_point)
			add_child(new_point)
			new_point.set_coord(Vector2(x,y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
