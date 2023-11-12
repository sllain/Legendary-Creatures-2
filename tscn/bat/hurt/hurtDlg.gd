extends BaseDlg

onready var box = $bg/ScrollContainer/VBoxContainer

signal onExit()

var itemRes = preload("res://tscn/bat/hurt/hurtItem.tscn")
var scene
var sortF = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	#sys.main.connect("onCharaHurt",self,"hurt")
	pass
	
func init(scene):
	scene.connect("onAddObj",self,"rAddObj")
	sys.game.connect("onBattleStart",self,"rStart")
	self.scene = scene
	sortF = "sortA"
	
func setMode(val=0):
	if val == 0 :
		$bg.rect_position = Vector2(2,63)
		$NinePatchRect.show()
	else:
		$bg.rect_position = Vector2(106,63)
		$NinePatchRect.hide()
		
func setTxt(s):
	$NinePatchRect/RichTextLabel.bbcode_text = s
	
func rStart():
	for i in box.get_children():
		i.queue_free()
	for i in scene.objMap.get_children() :
		if i is CharaV :
			rAddObj(i.chara)
func up():
	s = 0.0
	var arr:Array = box.get_children()
	arr.sort_custom(self,sortF)
	for i in arr.size():
		box.move_child(arr[i],i)
		arr[i].up()
		
func sortA(a,b):
	if a.a > b.a :return true
	return false
func sortD(a,b):
	if a.d > b.d :return true
	return false
func sortH(a,b):
	if a.h + a.w > b.h + b.w :return true
	return false
func sortB(a,b):
	if a.b1 + a.b2 > b.b1 + b.b2 :return true
	return false
		
func rAddObj(cha):
	#if scene.isBattle == false: return
	if cha.team != sys.player.team :return
	var it = itemRes.instance()
	box.add_child(it)
	it.init(cha)
		
func del():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_scale", Vector2(1,0), 0.1).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self,"hide")
	
func show():
	popup()
	rect_scale.y = 0.2
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	up()
	if $NinePatchRect.visible :
		$NinePatchRect/Button.grab_focus()

func rHide():
	del()
	pass # Replace with function body.
	
var s = 0.0
func _physics_process(delta):
	if visible == false:return
	s += delta
	if s > 0.5 :
		up()

func _on_hurt_pressed():
	sortF = "sortA"
	up()

func _on_hp_pressed():
	sortF = "sortH"
	up()

func _on_ward_pressed():
	sortF = "sortD"
	up()

func _on_b_pressed():
	sortF = "sortB"
	up()

func _on_Button_pressed():
	emit_signal("onExit")
