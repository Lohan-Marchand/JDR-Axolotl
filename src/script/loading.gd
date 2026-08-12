extends Control

var progress = []
var scene 
var scene_load_status = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(scene,progress)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(scene)
		add_sibling(new_scene.instantiate())
		queue_free()
	

func load_scene(scene_to_load : String):
	scene=scene_to_load
	PROPERTY_USAGE_DEFERRED_SET_RESOURCE
	ResourceLoader.load_threaded_request(scene)
	
	
