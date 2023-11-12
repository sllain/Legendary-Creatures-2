extends Control

signal onSel(cha)

var cha :Chara
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	var vari = data.newBase(sys.player.variPool.rndItem(self,"rndF").id) 
	$Button.hide()
	$variBtn.show()
	cha.varis.addItem(vari)
	$variBtn.init(vari)
	emit_signal("onSel",self)

func rndF(item):
	for i in cha.varis.items:
		if item.id == i.id :
			return false
	return true

func init(cha):
	self.cha = cha
	$name.text = "%s" % [tr(cha.name)]
	$name.set("custom_colors/font_color",Color(cons.colorDs.lvs[cha.lv-1]))
	$c_/anim.init(cha)
	sys.addTip($c_/ui/dragK,cha.dec)
	$popLv.init(cha)
func _on_dragK_pressed():
	var chaDlg = sys.newDlg("res://tscn/home/charaDlg/charaDlg.tscn")
	chaDlg.init(cha)


func _on_dragK_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($c_, "scale", Vector2(1.2,1.2), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_dragK_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($c_, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
