extends MarginContainer

var server_python_endpoint = "http://127.0.0.1:5000"

@onready var page_manager = get_node("/root/Control/HBoxContainer/MarginContainer/MainContent/PageManager")

@onready var button= $VBoxContainer/Button
@onready var input_field= $VBoxContainer/TextEdit
@onready var http_request = $HTTPRequest

func _ready():
	button.connect("pressed", on_button_submit)

func on_button_submit():
	print(input_field.text)

func _on_button_submit_response(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
