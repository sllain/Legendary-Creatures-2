extends Control
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var k = $k
var loca

# Called when the node enters the scene tree for the first time.
func _ready():
	$k/dec.modulate = Color("00ffffff")
	$k/lvBox.modulate = Color("00ffffff")

func init(loca):
	$k/tile/Label.text = loca.name
	$k/dec/txt.bbcode_text = loca.dec
	self.loca = loca
	$k/img.texture = data.newRes("img_" + loca.id)
	
	for i in loca.ts:
		var item = load("res://tscn/home/loca/lvItem.tscn").instance()
		$k/lvBox.add_child(item)
		item.init(i)

func _on_loca_pressed():
	loca._pressed()


func _on_TextureButton_pressed():
	loca._pressed()


func _on_btn_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(k, "rect_scale", Vector2(1.1,1.1), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property($k/dec, "modulate", Color("#ffffff"), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property($k/lvBox, "modulate", Color("#ffffff"), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_btn_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(k, "rect_scale", Vector2(1,1), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property($k/dec, "modulate", Color("#00ffffff"), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property($k/lvBox, "modulate", Color("#00ffffff"), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
