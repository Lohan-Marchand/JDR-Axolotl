extends Control

@onready var loading_screen : PackedScene = preload("res://scenes//loading.tscn")


func _on_btn_map_maker_pressed() -> void:
	var load_instance = loading_screen.instantiate()
	get_parent().add_child(load_instance)
	load_instance.load_scene("res://scenes/map_maker.tscn")
	queue_free()


func _on_btn_charcter_sheets_pressed() -> void:
	pass # Replace with function body.


func _on_btn_params_pressed() -> void:
	pass # Replace with function body.


func _on_btn_quit_pressed() -> void:
	get_tree().quit()


func _on_btn_partie_pressed() -> void:
	pass # Replace with function body.
