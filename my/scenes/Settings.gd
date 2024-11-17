extends Control

#dizionario che mantiene nodi e archi di uno scenario
@onready var graph = {
	"nodes": {},
	"edges": [],
	"os":    {}
}

#dizionario che mantiene i dati da mettere nel grafo (magari i dati per come sono arrivati dalla risposta)
@onready var data = {
		"nodes": [
			{"id": 1, "label": "A", "os":"ubuntu"},
			{"id": 2, "label": "B", "os":"windows"},
			#{"id": 3, "label": "C", "os":"ubuntu"}
		],
		"edges": [
			{"from": 1, "to": 2},
			#{"from": 2, "to": 3},
			#{"from": 3, "to": 1}
		]
	}
	
@export var icon_windows: Texture2D = ResourceLoader.load("res://icons/graph/windows_icon-icons.com_60494.svg")
@export var icon_ubuntu: Texture2D = ResourceLoader.load("res://icons/graph/ubuntu-svgrepo-com.svg")

func construct_graph(dictionary):
	for node in dictionary["nodes"]:
		graph["nodes"][node["id"]] = node["label"]
		graph["os"][node["id"]] = node["os"]
	
	for edge in dictionary["edges"]:
		graph["edges"].append({
			"from": edge["from"],
			"to": edge["to"]
		})

	print("Nodi:", graph["nodes"])
	print("Archi:", graph["edges"])
	print("OS:", graph["os"])
	
func draw_graph():
	var base_position = Vector2(100, 100)
	var spacing = 200
	var color = Color(0, 0, 0, 1) # Colore nero
	for node in graph["nodes"]:
		print("L'iterazione corrente è: "+str(node))
		var label = graph["nodes"][node]
		var os_value = graph["os"][node]
		print("Sto prendendo il nodo "+str(node)+" con sistema operativo "+str(os_value))
		var contenitore = VBoxContainer.new()
		#var bottone = Button.new()
		contenitore.set_size(Vector2(64,64))
		#bottone.set_size(Vector2(75,75))
		
		if os_value == "windows":
			var icon1 = TextureRect.new()
			var node_label = Label.new()
			
			$ColorRect.add_child(contenitore)
			contenitore.position = base_position + Vector2(spacing * int(node), 0)
			#contenitore.modulate = color
			#contenitore.add_child(bottone)
			
			#bottone.position = base_position + Vector2(spacing * int(node), 0)
			#bottone.modulate = color
			#contenitore.add_child(bottone)
			
			icon1.texture = icon_windows
			icon1.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
			#icon1.position = base_position + Vector2(spacing * int(node), 0)
			icon1.set_size(Vector2(25,25))
			contenitore.add_child(icon1)
			
			node_label.text = label
			node_label.modulate = color
			contenitore.add_child(node_label)
			#node_label.anchor_bottom = 0
			
		if os_value == "ubuntu":
			var icon2 = TextureRect.new()
			var node_label = Label.new()
			
			$ColorRect.add_child(contenitore)
			contenitore.position = base_position + Vector2(spacing * int(node), 0)
			#contenitore.modulate = color
			#add_child(bottone)
			
			#bottone.position = base_position + Vector2(spacing * int(node), 0)
			#contenitore.add_child(bottone)
			
			icon2.texture = icon_ubuntu
			icon2.stretch_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
			icon2.stretch_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
			#icon2.position = base_position + Vector2(spacing * int(node), 0)
			icon2.set_size(Vector2(70,70))
			contenitore.add_child(icon2)
			
			node_label.text = label
			node_label.modulate = color
			node_label.anchor_left = 0.5
			node_label.anchor_right = 0.5
			contenitore.add_child(node_label)
			#node_label.anchor_bottom = 0
			
	# Disegna gli archi come linee
	for edge in graph["edges"]:
		var from_id = edge["from"]
		var to_id = edge["to"]
		
		var from_position = base_position + Vector2((spacing * int(from_id))+68, 0+32)
		var to_position = base_position + Vector2(spacing * int(to_id)-5, 0+32)
		
		var line = Line2D.new()
		line.add_point(from_position)
		line.add_point(to_position)
		line.modulate=color
		add_child(line)

func _ready():
	construct_graph(data)
	draw_graph()
	

