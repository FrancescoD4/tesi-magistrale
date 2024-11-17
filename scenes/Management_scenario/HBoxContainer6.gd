extends HBoxContainer

@onready var input = $HBoxContainer6/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	input.locate(Vector2())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
