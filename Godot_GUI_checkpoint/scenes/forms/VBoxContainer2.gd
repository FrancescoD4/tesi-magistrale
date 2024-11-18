extends VBoxContainer
var server_python_endpoint = "http://127.0.0.1:5000"
@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")
@onready var http_request = $HTTPRequest 
@onready var back_button = get_node("./ButtonContainerVM/BackButton2")
@onready var create_button = get_node("./ButtonContainerVM/CreateButton2")
@onready var get_all_resources_button = $ButtonContainerVM/GetAllResourcesButton

func _ready():
	back_button.connect("pressed", _on_Back_button_pressed)
	create_button.connect("pressed", _on_Create_button_pressed)

func _on_Back_button_pressed():
	page_manager.change_page("res://scenes/Management_scenario/Management_scenario.tscn")
	
func _on_Create_button_pressed():
	
	var scenario_data = {
		"vm_id": $HBoxContainer/VBoxContainer/Wrapper_ID/HContainerVMID/SpinBox.value,
		"vm_name": $HBoxContainer/VBoxContainer/Wrapper_Name/HContainerName/LineEdit.text
		#"vm_memory": $HBoxContainer/VBoxContainer/HContainerMemory/SpinBox.value,
		#"vm_cores": $HBoxContainer/VBoxContainer/HContainerCores/SpinBox.value,
		#"vm_cpu": $HBoxContainer/VBoxContainer2/HContainerDisk/LineEdit.text,
		#"vm_net0": $HBoxContainer/VBoxContainer/Wrapper_Net0/HContainerNet0/LineEdit.text,
		#"vm_scsihw":$HBoxContainer/VBoxContainer/Wrapper_Scsi0/HContainerScsi0/LineEdit.text,
		#"vm_scsi0":$HBoxContainer/VBoxContainer/Wrapper_Scsi0/HContainerScsi0/LineEdit.text,
		#"vm_ide0": $HBoxContainer/VBoxContainer2/Wrapper_Ide/HContainerIde/OptionButton.text,
		#"vm_osype":$HBoxContainer/VBoxContainer2/Wrapper_Ostype/HContainerOstype/OptionButton.text,
		#"vm_boot":$HBoxContainer/VBoxContainer2/WrapperBoot/HContainerBoot/OptionButton.text,
		#"vm_bootdisk":$HBoxContainer/VBoxContainer2/WrapperBootdisk/HContainerBootdisk/LineEdit.text,
		#"vm_sockets": $HBoxContainer/VBoxContainer2/WrapperSockets/HContainerSockets/SpinBox.value,
		#"vm_agent": $HBoxContainer/VBoxContainer2/WrapperAgent/HContainerAgent/OptionButton.text,
		#"vm_vga": $HBoxContainer/VBoxContainer2/Wrapper_Vga/HContainerVga/OptionButton.text,
		#"vm_serial0": $HBoxContainer/VBoxContainer2/WrapperSerial/HContainerSerial0/LineEdit.text
			
	}
	
	send_vm_creation_request(scenario_data)

func send_vm_creation_request(json_data):
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/create_vm", headers, HTTPClient.METHOD_POST, str(json_data))

func _on_vm_creation_response(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print("La risposta su godot di create vm è:")
	print(json)
	

