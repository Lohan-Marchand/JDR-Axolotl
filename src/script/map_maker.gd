extends Control
@onready var map_maker_menu: FoldableContainer = $"Map Maker Menu"
@onready var shapes: Node2D = $Map/Shapes
@onready var map: Node2D = $Map

enum ToolCategorie {
	WALL
}
enum Tool {
	NONE,
	LINE,
	RECTANGLE,
	FREE
}

var current_tool : Tool
var current_tool_categorie : ToolCategorie

func change_tool(categorie : ToolCategorie, tool : Tool):
	if(current_tool_categorie!=categorie):
		pass
	if(current_tool!=tool):
		current_tool=tool
		if(categorie==ToolCategorie.WALL):
			shapes.change_tool(tool)

func _on_zoom_in_pressed() -> void:
	map.scale*=2


func _on_zoom_out_pressed() -> void:
	map.scale/=2
