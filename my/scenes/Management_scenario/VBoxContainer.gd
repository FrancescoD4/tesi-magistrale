extends VBoxContainer

@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")

func _ready():
	$HBoxContainer2_buttons/BackButton.connect("pressed", _on_Back_button_pressed)
	$HBoxContainer2_buttons/CreateButton.connect("pressed", _on_CreateVM_button_pressed)
	
func _on_Back_button_pressed():
	page_manager.change_page("res://scenes/Dashboard.tscn")
	
#func _on_Destroy_button_pressed():
	#page_manager.change_page("res://scenes/Dashboard.tscn")

func _on_CreateVM_button_pressed():
	page_manager.change_page("res://scenes/forms/add_vm.tscn")
