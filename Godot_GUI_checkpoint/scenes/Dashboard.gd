extends Control

var server_python_endpoint = "http://127.0.0.1:5000"


@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")
@onready var item_list = $VBoxContainer/VBoxContainer/ItemList
@onready var http_request = $HTTPRequest


#tagVlan : Nome Scenario
# { "10": "Scenario-10" }
var data = {}

func _ready():
	#per ottenere tutte le macchine sul nodo pve
	#http_request.request_completed.connect(_on_get_all_scenarios_response)
	#send_get_all_scenarios()
	
	#---per ottenere uno scenario per ogni VLAN ---#
	http_request.request_completed.connect(_on_get_a_scenario_for_each_vlan)
	send_get_a_scenario_for_each_vlan()
	
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
		
func send_get_a_scenario_for_each_vlan():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/get_couples_vlan_scenarioName", headers, HTTPClient.METHOD_GET)

func _on_get_a_scenario_for_each_vlan(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	data=json["scenarios"]
	print(data)

	# Itera su ogni coppia chiave-valore nel Dictionary
	for key in data.keys():
		var value = data[key]
		print("Chiave:", key, "Valore:", value)
		item_list.add_item(value)


