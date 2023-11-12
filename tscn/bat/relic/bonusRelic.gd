extends NinePatchRect


signal pressed()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(item):
	$item.init(item)
#	if item != null:
#		$item/CrystalWhite.modulate = Color(cons.colorDs.lvs[item.lv-1])

func _on_Button_pressed():
	emit_signal("pressed")
