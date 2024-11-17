extends Control

#@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager") 
@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(page_manager)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
