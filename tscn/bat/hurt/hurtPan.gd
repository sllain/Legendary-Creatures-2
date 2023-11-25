extends Control

onready var box = $ScrollContainer/VBoxContainer

signal onExit()

var itemRes = load("res://tscn/bat/hurt/hurtItem.tscn")
var scene
var sortF = ""
var isPlayer = true
# Called when the node enters the scene tree for the first time.
func _ready():
	#sys.main.connect("onCharaHurt",self,"hurt")
	pass
	
func init(scene,isPlayer):
	self.isPlayer = isPlayer
	scene.connect("onAddObj",self,"rAddObj")
	self.scene = scene
	sortF = "sortA"
	yield(get_tree().create_timer(0.1),"timeout")
	rStart()
	
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
	if isPlayer :
		if cha.team != sys.player.team :return
	else:
		if cha.team == sys.player.team :return
	var it = itemRes.instance()
	box.add_child(it)
	it.init(cha)
	
var s = 0.0
func _physics_process(delta):
	if visible == false:return
	s += delta
	if s > 0.5 :
		up()

func _on_b_pressed():
	sortF = "sortB"
	up()

func _on_hurtPan_visibility_changed():
	if visible :
		up()


func _on_a_pressed():
	sortF = "sortA"
	up()


func _on_d_pressed():
	sortF = "sortD"
	up()


func _on_h_pressed():
	sortF = "sortH"
	up()
