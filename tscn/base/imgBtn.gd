extends TextureButton
class_name ImgBtn

onready var node = $node
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	connect("mouse_entered",self,"_entered")
	connect("mouse_exited",self,"_exit")


func _entered():
	var tween = get_tree().create_tween()
	tween.tween_property(node, "scale", Vector2(1.2,1.2), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _exit():
	var tween = get_tree().create_tween()
	tween.tween_property(node, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func setImg(t):
	$node/img.texture = t

func setText(txt):
	$Label.text = txt
