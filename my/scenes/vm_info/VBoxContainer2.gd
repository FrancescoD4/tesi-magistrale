extends VBoxContainer

var server_python_endpoint = "http://127.0.0.1:5000"
@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")
@onready var http_request = $HTTPRequest 
@onready var back_button = get_node("./ButtonContainerVM/BackButton2")
@onready var delete_button = get_node("./ButtonContainerVM/Delete_vm_Button")
@onready var identifier = page_manager.current_resource_id

func _ready():
	$Label.text="Add a resource to the scenario: "+ page_manager.current_scenario
	back_button.connect("pressed", on_back_button_pressed)
	delete_button.connect("pressed", on_delete_button_pressed)
	http_request.request_completed.connect(_on_get_vm)
	send_get_vm()

func send_get_vm():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/scenario/get_vm/"+str(identifier), headers, HTTPClient.METHOD_GET)

func _on_get_vm(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
	$HBoxContainer/VBoxContainer/Wrapper_ID/HContainerVMID/Label2.text = str(json['vmid'])
	$HBoxContainer/VBoxContainer/Wrapper_Name/HContainerName/Label2.text = json['name']
	$HBoxContainer/VBoxContainer/Wrapper_disk/HContainerDisk/Label2.text = str(json['disk'])
	$HBoxContainer/VBoxContainer2/Wrapper_mem/HContainerMem/Label2.text = str(json['mem'])
	$HBoxContainer/VBoxContainer2/WrapperNetin/HContainerNetin/Label2.text = str(json['netin'])
	$HBoxContainer/VBoxContainer2/WrapperNetout/HContainerNetout/Label2.text = str(json['netout'])
	$HBoxContainer/VBoxContainer/Wrapper_maxmem/HContainerMaxmem/Label2.text = str(json['maxmem'])
	$HBoxContainer/VBoxContainer/Wrapper_status/HContainerStatus/Label2.text = json['status']
	$HBoxContainer/VBoxContainer/Wrapper_uptime/HContainerUptime/Label2.text = str(json['uptime'])
	$HBoxContainer/VBoxContainer/Wrapper_Cpus/HContainerCpus/Label2.text = str(json['cpus'])
	$HBoxContainer/VBoxContainer/Wrapper_maxdisk/HContainermaxdisk/Label2.text = str(json['maxdisk'])

func on_back_button_pressed():
	page_manager.change_page("res://scenes/Management_scenario/Management_scenario.tscn")
	
func on_delete_button_pressed():
	delete_vm()

func delete_vm():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/delete_vm/"+str(identifier), headers, HTTPClient.METHOD_DELETE)

func on_delete_button_response(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
