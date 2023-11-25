extends BaseDlg


signal onExit()

var scene
# Called when the node enters the scene tree for the first time.
func _ready():
	#sys.main.connect("onCharaHurt",self,"hurt")
	pass
	
func init(scene):
	$bg/hurtPan1.init(scene,true)
	$bg/hurtPan2.init(scene,false)
	_on_pan1Btn_pressed()
	
func setMode(val=0):
	if val == 0 :
		$bg.rect_position = Vector2(2,63)
		$NinePatchRect.show()
	else:
		$bg.rect_position = Vector2(106,63)
		$NinePatchRect.hide()
		
func setTxt(s):
	$NinePatchRect/RichTextLabel.bbcode_text = s
	
		
func del():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_scale", Vector2(1,0), 0.1).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self,"hide")
	
func show():
	popup()
	rect_scale.y = 0.2
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	if $NinePatchRect.visible :
		$NinePatchRect/Button.grab_focus()

func rHide():
	del()
	pass # Replace with function body.

func _on_Button_pressed():
	emit_signal("onExit")


func _on_pan1Btn_pressed():
	$bg/hurtPan1.show()
	$bg/hurtPan2.hide()

func _on_pan2Btn_pressed():
	$bg/hurtPan2.show()
	$bg/hurtPan1.hide()
