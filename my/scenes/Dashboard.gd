extends Control

var server_python_endpoint = "http://127.0.0.1:5000"

@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")
@onready var item_list = $VBoxContainer/VBoxContainer/ItemList
@onready var http_request = $HTTPRequest

func _ready():
	http_request.request_completed.connect(_on_get_all_scenarios_response)
	send_get_all_scenarios()
	item_list.connect("item_clicked", _on_item_list_item_clicked)
	
func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int):
	var selected_item_text = item_list.get_item_text(index)
	print("Elemento cliccato:", selected_item_text)

	page_manager.current_scenario = selected_item_text
	page_manager.change_page("res://scenes/Management_scenario/Management_scenario.tscn") 
#
func send_get_all_scenarios():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/get_all_scenarios", headers, HTTPClient.METHOD_GET)

func _on_get_all_scenarios_response(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	for i in range(json.size()):
		item_list.add_item(json[i]['node'])
