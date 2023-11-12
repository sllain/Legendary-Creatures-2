extends NinePatchRect



var cha 
var loca
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(cha,loca):
	self.cha = cha
	self.loca = loca
	$name.text = "%s" % [cha.name]
	$name.set("custom_colors/font_color",Color(cons.colorDs.lvs[cha.lv-1]))
	$c_/anim.init(cha)
	sys.addTip($c_/ui/dragK,cha.dec)
	$popLv.init(cha)
func _on_dragK_pressed():
	var chaDlg = sys.newDlg("res://tscn/home/charaDlg/charaDlg.tscn")
	chaDlg.init(cha)

func _on_Button_pressed():
	if loca.playerAddAlterCha(cha) :
		queue_free()
	else:
		sys.newMsg("后备军满了")


func _on_dragK_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($c_, "scale", Vector2(1.2,1.2), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_dragK_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($c_, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
