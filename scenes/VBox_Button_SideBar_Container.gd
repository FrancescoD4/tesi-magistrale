extends VBoxContainer

@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")

func _ready():
	$HBoxContainer_edit/Edit_Button.connect("pressed", _on_Edit_button_pressed)
	$HBoxContainer_dash/Dash_Button.connect("pressed", _on_Dashboard_button_pressed)
	$HBoxContainer_llm/LLM_Button.connect("pressed", _on_Llm_button_pressed)

func _on_Dashboard_button_pressed():
	page_manager.change_page("res://scenes/Dashboard.tscn")

func _on_Edit_button_pressed():
	page_manager.change_page("res://scenes/Management_scenario/Management_scenario.tscn")
	
func _on_Llm_button_pressed():
	page_manager.change_page("res://scenes/llm/llm_scene.tscn") 

