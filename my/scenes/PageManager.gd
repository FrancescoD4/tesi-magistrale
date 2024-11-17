extends Node

var current_page = null
var current_scenario ="current_scenario"
var current_resource ="current_resource"
var current_resource_id=0

func change_page(scene_path):
	if current_page:
		current_page.queue_free()
	
	var new_page_scene = load(scene_path)
	current_page = new_page_scene.instantiate()

	get_parent().add_child(current_page)
