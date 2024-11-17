extends VBoxContainer

@onready var page_manager = get_node("/root/Control/HBoxContainer/MainContent/PageManager")

func _ready():
	# Connetti i pulsanti agli eventi di cambio pagina
	$HBoxContainer_dash/Dash_Button.connect("pressed", _on_Dashboard_button_pressed)
	$HBoxContainer_node/Node_Button.connect("pressed", _on_Node_button_pressed)
	$HBoxContainer_settings/Settings_Button.connect("pressed", _on_Settings_button_pressed)
	$HBoxContainer_score/Scoreboard_Button.connect("pressed", _on_Scoreboard_button_pressed)

func _on_Dashboard_button_pressed():
	page_manager.change_page("res://scenes/Dashboard.tscn")

func _on_Node_button_pressed():
	page_manager.change_page("res://scenes/Page1.tscn")
	
func _on_Settings_button_pressed():
	page_manager.change_page("res://scenes/Settings.tscn")

func _on_Scoreboard_button_pressed():
	page_manager.change_page("res://scenes/Scoreboard.tscn")
