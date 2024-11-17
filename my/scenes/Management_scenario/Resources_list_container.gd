extends VBoxContainer

var server_python_endpoint = "http://127.0.0.1:5000"
@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")
@onready var http_request = $HTTPRequest
@onready var item_list = $ScrollContainer_rs/VBoxContainer2_rs/ItemList
var json={}

func _ready():
	http_request.request_completed.connect(_on_get_all_scenario_vms)
	send_get_scenario_vms()
	item_list.connect("item_clicked", _on_item_list_item_clicked)

func send_get_scenario_vms():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/scenario=pve/get_vms", headers, HTTPClient.METHOD_GET)

func _on_get_all_scenario_vms(result, response_code, headers, body):
	json = JSON.parse_string(body.get_string_from_utf8())
	
	for i in range(json.size()):
		
		item_list.add_item(json[i]['name']+" (vmid:"+str(json[i]['vmid'])+")")

func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int):
	var selected_item_text = item_list.get_item_text(index)
	print("Elemento cliccato:", selected_item_text)

	var start_index = selected_item_text.find(":")
	var end_index = selected_item_text.find(")")
	if start_index != -1 and end_index != -1:
		var result = selected_item_text.substr(start_index + 1, end_index - start_index - 1)
		page_manager.current_resource_id= result
	page_manager.current_resource = selected_item_text
	page_manager.change_page("res://scenes/vm_info/vm_info.tscn") 

