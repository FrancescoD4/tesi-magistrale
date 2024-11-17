extends VBoxContainer

@onready var option_button = $OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	option_button.add_item("Scenario1")
	option_button.add_item("Scenario2")
	option_button.add_item("Scenario3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
