extends Container

var scenario_card1
var scenario_card2
var scenario_card3
var scenario_card4

var scene = preload("res://scenes/Dashboard_scenes/ScenarioCard.tscn")

func load_scenario_card(scene_path):
	var instance = scene.instantiate()
	get_parent().add_child(instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
