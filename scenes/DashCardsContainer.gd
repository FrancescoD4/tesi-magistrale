extends HBoxContainer

#$ScenarioCard.add_theme_color_override("modulate", Color(50,143,84))
func _ready():
	$DashCardsContainer.size_flags_horizontal = Control.SIZE_FILL | Control.SIZE_EXPAND
	$DashCardsContainer.size_flags_vertical = Control.SIZE_FILL
	$DashCardsContainer.anchor_left = 0
	$DashCardsContainer.anchor_right = 1
	$DashCardsContainer.anchor_top = 0
	$DashCardsContainer.anchor_bottom = 1
	$DashCardsContainer.grow_horizontal = Control.GROW_DIRECTION_BOTH
	
	$ScenarioCard.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_FILL
	$ScenarioCard.size_flags_vertical = Control.SIZE_FILL
	
	$ScenarioCard2.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_FILL
	$ScenarioCard2.size_flags_vertical = Control.SIZE_FILL
	
	$ScenarioCard3.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_FILL
	$ScenarioCard3.size_flags_vertical = Control.SIZE_FILL
	
	$ScenarioCard4.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_FILL
	$ScenarioCard4.size_flags_vertical = Control.SIZE_FILL

	add_child($DashCardsContainer)

	# Aggiunta dei 4 nodi figli
	#for i in range(4):
	#	var button = Button.new()
	#	button.text = "Button %d" % i
	#	button.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_FILL
	#	button.size_flags_vertical = Control.SIZE_FILL
	#	hbox.add_child(button)
