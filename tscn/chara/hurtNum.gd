extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(val,colorStr):
	text = "%d" % val
	var tw = create_tween()
	self_modulate = Color(colorStr)
	var c = Color(colorStr)
	c.a = 0.3
	tw.tween_interval(0.5)
	tw.tween_property(self,"self_modulate",c, 0.5)
	tw.tween_callback(self, "queue_free")
	
