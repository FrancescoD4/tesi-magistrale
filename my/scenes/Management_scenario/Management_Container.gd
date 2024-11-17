extends HBoxContainer

@onready var topology_node = get_node("VBoxContainer/Management_Container/VBoxContainer/Topology_node")

func _ready():
	# Connetti i pulsanti agli eventi di cambio pagina
	$VBoxContainer3/ButtonContainerVM/BackButton.connect("pressed", _on_Back_button_pressed)
	$VBoxContainer3/ButtonContainerVM/EditButton.connect("pressed", _on_Edit_button_pressed)

func _on_Edit_button_pressed():
	topology_node.change_page("res://scenes/Dashboard.tscn")

func _on_Back_button_pressed():
	topology_node.change_page("res://scenes/Dashboard.tscn")
	
