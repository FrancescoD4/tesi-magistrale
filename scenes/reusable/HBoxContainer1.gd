extends HBoxContainer

@export var name_title: String = "no"
@export var id		  : String = "no"

func set_name_title(new_name: String):
	name_title=new_name
	$Panel/H_txt_info_container/txt_label.text = "Name :" + new_name
