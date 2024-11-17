extends Control

var is_sidebar_expanded = true

@onready var sidebar_panel = $HBoxContainer/SideBar
@onready var main_content = $HBoxContainer/MarginContainer/MainContent
@onready var toggle_button = $HBoxContainer/SideBar/VBox_Button_SideBar_Container/HBoxContainer/ToggleButton
@onready var node_button = $HBoxContainer/SideBar/VBox_Button_SideBar_Container/HBoxContainer_edit/Edit_Button
@onready var margin_container = $HBoxContainer/MarginContainer
@onready var node_container = $HBoxContainer/SideBar/VBox_Button_SideBar_Container/HBoxContainer_edit
@onready var dash_container = $HBoxContainer/SideBar/VBox_Button_SideBar_Container/HBoxContainer_dash
@onready var llm_container = $HBoxContainer/SideBar/VBox_Button_SideBar_Container/HBoxContainer_llm

var node_label = Label.new()
var dash_label = Label.new()
var create_label = Label.new()
var llm_label = Label.new()

var color = Color(191, 219, 254) # Colore nero

func _ready():
	DisplayServer.window_set_min_size(Vector2(1280, 720))
	toggle_button.pressed.connect(_on_toggle_button_pressed)
	_update_sidebar()

func _on_toggle_button_pressed():
	is_sidebar_expanded = not is_sidebar_expanded
	_update_sidebar()
		
func _update_sidebar():
	if is_sidebar_expanded:
		var viewport_size = get_viewport().size
		sidebar_panel.custom_minimum_size = Vector2(260,720)
		margin_container.custom_minimum_size = Vector2(1020,720)
		main_content.custom_minimum_size = Vector2(1010,710)

		node_label.text = "Scenario Management"
		node_container.add_child(node_label)
		node_label.add_theme_color_override("font_color", color)
		
		dash_label.text = "Dashboard"
		dash_container.add_child(dash_label)
		dash_label.add_theme_color_override("font_color", color)
		
		llm_label.text = "LLM component"
		llm_container.add_child(llm_label)
		llm_label.add_theme_color_override("font_color", color)
		
	else:
		node_container.remove_child(node_label)
		dash_container.remove_child(dash_label)
		llm_container.remove_child(llm_label)

		sidebar_panel.custom_minimum_size = Vector2(62,720)
		margin_container.custom_minimum_size = Vector2(1218,720)
		main_content.custom_minimum_size = Vector2(1208,710)
