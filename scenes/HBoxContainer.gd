extends HBoxContainer

#var collapsed = false;

#func _ready():

	# Connetti al segnale di ridimensionamento della finestra
	#get_viewport().connect("size_changed", _on_size_changed)

#func _on_size_changed():
	#var viewport_size = get_viewport().size
	#var panel = $SideBar
	#var vbox = $MarginContainer/MainContent
	#var button_container = $SideBar/VBox_Button_SideBar_Container
	
	# Adatta la larghezza del Panel
	#panel.custom_minimum_size = Vector2(viewport_size / 5) # Larghezza fissa o calcola in base alle dimensioni della finestra
	#vbox.custom_minimum_size = Vector2(viewport_size / 5)*4
	


