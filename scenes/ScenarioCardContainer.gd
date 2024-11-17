extends HBoxContainer

@onready var scenario_card1 = $ScenarioCard1
@onready var scenario_card2 = $ScenarioCard1
@onready var scenario_card3 = $ScenarioCard1
@onready var scenario_card4 = $ScenarioCard1 


# Called when the node enters the scene tree for the first time.
func _ready():
	scenario_card1.load_scenario_card("res://scenes/Dashboard_scenes/ScenarioCard.gd")
	scenario_card2.load_scenario_card("res://scenes/Dashboard_scenes/ScenarioCard.gd")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
