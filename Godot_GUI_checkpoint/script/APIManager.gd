extends Node

@onready var http_request = get_node("/root/Control/HTTPRequest")
@onready var item_list_dashboard = get_node("/Dashboard/VBoxContainer/VBoxContainer/ItemList")

var server_python_endpoint = "http://127.0.0.1:5000"
#var create_vm_server_python_endpoint = "http://127.0.0.1:5000/create_vm"
#var prova_server_python_endpoint = "http://127.0.0.1:5000/prova"

#CREATE VM
func send_vm_creation_request(json_data, http_request):
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/create_vm", headers, HTTPClient.METHOD_POST, json_data)

func _on_vm_creation_response(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print("La risposta su godot di create vm è:")
	print(json)

#DELETE VM
func send_vm_delete_request(json_data, http_request):
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/delete_vm", headers, HTTPClient.METHOD_DELETE, json_data)

func _on_vm_delete_response(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)

#GER RESOURCES
func send_get_all_scenarios(http_request):
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/get_all_scenarios", headers, HTTPClient.METHOD_GET)


func _on_get_all_scenarios_response(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)


#---------------------------------------------------------------------------------------------------UTILITA'
func save_to_file(content):
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(content)

func load_from_file():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var content = file.get_as_text()
	return content

	

