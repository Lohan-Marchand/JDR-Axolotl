extends FoldableContainer
@onready var mur: MenuButton = $TabContainer/Tab1/Mur
@onready var map_maker: Control = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mur.get_popup().id_pressed.connect(mur_pressed)
	pass # Replace with function body.

func mur_pressed(id):
	match id:
		0:
			map_maker.change_tool(map_maker.ToolCategorie.WALL, map_maker.Tool.LINE)
		1:
			map_maker.change_tool(map_maker.ToolCategorie.WALL,map_maker.Tool.RECTANGLE)
		2:
			map_maker.change_tool(map_maker.ToolCategorie.WALL,map_maker.Tool.FREE)
