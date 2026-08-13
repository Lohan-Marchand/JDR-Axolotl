extends FoldableContainer
@onready var mur: MenuButton = $TabContainer/Tab1/Mur

var current_tool : String =""
var current_categorie : String =""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mur.get_popup().id_pressed.connect(mur_pressed)
	pass # Replace with function body.

func mur_pressed(id):
	current_categorie = "wall"
	match id:
		0:
			current_tool="line"
		1:
			current_tool="rectangle"
		2:
			current_tool="free"


func get_current_tool():
	return current_tool

func get_current_categorie():
	return current_categorie

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
