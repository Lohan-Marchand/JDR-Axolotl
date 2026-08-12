extends Control
const HOME_MENU = preload("uid://b74yqlnddqifk")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var menu = HOME_MENU.instantiate()
	self.add_child(menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
