extends Button

func _ready():
	var texture_rect = $TextureButton
	texture_rect = load("res://icons/delete.svg")  # Carica l'icona
	#texture_rect.rect_min_size = Vector2i(30, 30)  # Imposta la dimensione minima (ridimensiona l'icona)
	#texture_rect.stretch_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL  # Ridimensiona l'immagine per adattarla
	#texture_rect.stretch_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	add_child(texture_rect)
