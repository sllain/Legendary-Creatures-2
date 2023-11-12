extends Popup
class_name BasePopup

signal onDel()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	hide()
	if is_connected("about_to_show",self,"_show") == false:
		connect("about_to_show",self,"_show")
# Called when the node enters the scene tree for the first time.
func _ready():
	rect_scale.y = 0.2
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	connect("hide",self,"rHide")
	
func rHide():
	show()
	del()

func del():
	emit_signal("onDel")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_scale", Vector2(1,0), 0.1).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self,"queue_free")
	#sys.playSe("x.wav")

func _show():
	sys.playSe("msg.wav")
