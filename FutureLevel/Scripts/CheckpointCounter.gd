extends Label



func _process(_delta: float) -> void:
	text = "Lives: %d" % Global.lives
