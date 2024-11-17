extends Control

@onready var http_request = $HTTPRequest
var server_python_endpoint = "http://127.0.0.1:5000"
@onready var title = $Panel/VBoxContainer/Label

func _ready():
	if title.text == 'Running':
		http_request.request_completed.connect(_on_get_resources_in_state_running)
		send_get_resources_in_state_running()
	if title.text == 'Stopped':
		http_request.request_completed.connect(_on_get_resources_in_state_stopped)
		send_get_resources_in_state_stopped()
	if title.text == 'Paused':
		http_request.request_completed.connect(_on_get_resources_in_state_paused)
		send_get_resources_in_state_paused()
	if title.text == 'Suspended':
		http_request.request_completed.connect(_on_get_resources_in_state_suspended)
		send_get_resources_in_state_suspended()

func send_get_resources_in_state_running():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/pve/get_resources_in_state/running", headers, HTTPClient.METHOD_GET)

func _on_get_resources_in_state_running(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	$Panel/VBoxContainer/Label2.text = 'Counts : '+ str(json["running_vms"])

func send_get_resources_in_state_stopped():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/pve/get_resources_in_state/stopped", headers, HTTPClient.METHOD_GET)

func _on_get_resources_in_state_stopped(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	$Panel/VBoxContainer/Label2.text = 'Counts : '+ str(json["stopped_vms"])
	
func send_get_resources_in_state_paused():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/pve/get_resources_in_state/paused", headers, HTTPClient.METHOD_GET)

func _on_get_resources_in_state_paused(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	$Panel/VBoxContainer/Label2.text = 'Counts : '+ str(json["paused_vms"])
	
func send_get_resources_in_state_suspended():
	var headers = ["Content-Type: application/json"]
	http_request.request(server_python_endpoint+"/pve/get_resources_in_state/suspended", headers, HTTPClient.METHOD_GET)

func _on_get_resources_in_state_suspended(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	$Panel/VBoxContainer/Label2.text = 'Counts : '+ str(json["suspended_vms"])

