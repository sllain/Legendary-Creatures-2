extends ItemBtn


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal onSel()

func _on_Button_pressed():
	emit_signal("onSel")
