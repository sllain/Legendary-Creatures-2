extends ObjV
class_name CharaV

signal onPressed()

onready var anim = $anim
onready var box = $ui/box
onready var eqps = $ui/v/eqps
var animScale = 1.5
var chara:Chara
var isDrag = false
var isDeathDel = true

var valPlusHp = 0
var valPlusW = 0
var valHurt = 0
var valHurtM = 0
var valHurtR = 0

func init(obj,isDrag = false):
	.init(obj)
	self.isDrag = isDrag
	chara = obj
	#chara.connect("onDeath",self,"rDeath")
	self.chara.connect("onHurt",self,"rHurt")
	self.chara.connect("onPlus",self,"rPlus")
	self.chara.connect("onPlusLv",self,"rPlusLv")
	chara.connect("onPlayAnim",self,"playAnim")
	$ui/hpBar.init(obj)
	$ui/dragK.init(self)
	anim.init(chara)
	$ui/v/popLv.init(chara)
	sys.addTip($ui/dragK,obj.dec)
	for i in self.chara.eqps.items:
		var btn = preload("res://tscn/item/itemChaBtn.tscn").instance()
		eqps.add_child(btn)
		btn.init(i)
	self.chara.eqps.connect("onUp",self,"up")
	$ui/dragK.chara = chara
	playAnim(chara.nowAnim)
	self.chara.connect("onNewBuffEff",self,"newBuffEff")
	for i in chara.affs:
		if i.get("effId") != null:
			newBuffEff(i)
	#$hpBar.position.y = chara.imgCenterPos.y * 2
	chara.connect("onPlusXp",self,"_onPlusXp")
	$ui/buffs.init(chara)
	$ui/buffs.visible = false

func up(inx,item1,item2):
	eqps.get_child(inx).init(chara.eqps.items[inx])
	
func _onPlusXp(val):
	if val > 0 :
		pass

func _physics_process(delta):
	chara._process(delta)
	if chara.yunTime <= 0 :
		_aiAct(delta)
	for i in chara.affs:
		if i is Buff :
			i._process(delta)
	if valHurt > 0 || valHurtM > 0 || valHurtR :
		var eff = obj.scene.newEff(eid,chara.position,chara.imgCenterPos)
		eff.get_node("up/anim").rotation_degrees = rand_range(0,360)
	if valHurt > 0 :
		effNum(valHurt,"#ff6c6c")
		valHurt = 0
	if valHurtM > 0 :
		effNum(valHurtM,"#6ca5ff")
		valHurtM = 0
	if valHurtR > 0 :
		effNum(valHurtR,"#ffffff")
		valHurtR = 0
	if valPlusHp > 0 :
		effNum(valPlusHp,"#5bcb56")
		valPlusHp = 0 
	if valPlusW > 0 :
		effNum(valPlusW,"#e8ec1b")
		valPlusW = 0 
	if chara.yingTime > 0 :
		anim.self_modulate.a = 0.5
	else:
		anim.self_modulate.a = 1
	
	if seekTime > 0 : seekTime -= delta

var seekTime = 0.0
func setProcess(val = false):
	set_physics_process(val)
	set_process(val)
	.setProcess(val)
	if val == true: _aiAct(0)
	$ui/v.visible = !val
	$ui/buffs.visible = val
	
func rPlusLv():
	pass

func _aiAct(delta):
	if seekTime > 0 :return
	if obj.aiCha == null || obj.aiCha.isDeath || obj.aiCha.yingTime > 0 :
		chara.aiSeekCha()
		seekTime = rand_range(0,0.05)
		#obj.scene.addQueue(chara,"aiSeekCha")
		return
	var l = obj.distanceTo(obj.aiCha)
	for i in chara.skills.items:
		if i != null && i.castStart():return
	if l <= obj.ran:
		obj.goalCell = null
		obj.atkNorm()
	elif obj.aiCha != null && obj.canMove:
		obj.goalCell = obj.aiCha.cell

func _ifMove():
	return obj.isNormAnim()
	
func _moveStart():
	direToPos(nextTgPos)
	if obj.nowAnim != "move":
		obj.playAnim("move")
		
func _moveEnd():
	pass

func playAnim(id,spd = 1.0):
	if anim.frames.has_animation(id) == false:
		id = "atk"
		sys.playSe("knife2.wav")
	elif id == "buff" :
		sys.playSe("FlyObj.wav")
	elif id == "atk2" :
		sys.playSe("knife2.wav")
		
	anim.play(id)
	anim.speed_scale = spd
	if chara.nowAnim != "move" && chara.aiCha != null:
		direToPos(chara.aiCha.position)
	var t = anim.frames.get_frame(id,0)
	anim.position.y = -t.get_height() * anim.scale.y * 0.5  + 5
		
func direToPos(pos):
	if chara.aiCha != null:
		chara.dire =  pos.x -position.x

func _del():
	$ui/hpBar.hide()
	chara.playAnim("death")
	set_process(false)
	set_physics_process(false)
	
var eid
func rHurt(atkInfo):
	if atkInfo.hurtType == Base.HURTTYPE.PHY :
		valHurt += atkInfo.finalVal
	elif atkInfo.hurtType == Base.HURTTYPE.MAG :
		valHurtM += atkInfo.finalVal
	elif atkInfo.hurtType == Base.HURTTYPE.REAL :
		valHurtR += atkInfo.finalVal
		
	
	if atkInfo.val >= atkInfo.castCha.atk * 4:
		eid = "e_hit3"
		sys.playSe("KnifeHit3.wav")
	elif atkInfo.val >= atkInfo.castCha.atk * 2:
		eid = "e_hit2"
		sys.playSe("KnifeHit2.wav")
	else:
		eid = "e_hit1"
		sys.playSe("KnifeHit1.wav")
	
func effNum(val,c):
	var eid
	
	var num = load("res://tscn/chara/hurtNum.tscn").instance()
	box.add_child(num)
	num.init(val,c)
	
func rPlus(info):
	if info.type == "hp" :
		valPlusHp += info.finalVal
	elif info.type == "ward" :
		valPlusW += info.finalVal

func _on_dragK_pressed():
	emit_signal("onPressed")
	sys.newDlg("res://tscn/charaDlg/charaDlg.tscn").init(chara)

func _on_anim_animation_finished():
	if chara.nowAnim == "death":
		if isDeathDel :
			._del()
	elif chara.nowAnim != "move":
		chara.playAnim("idle")
func _on_dragK_mouse_entered():
	sys.addTip($ui/dragK,obj.dec)
	pass # Replace with function body.

func newBuffEff(buff:Buff):
	if buff.get("effId") != null:
		var eff = data.newRes(buff.effId).instance()
		add_child(eff)
		eff.position = chara.imgCenterPos
		buff.connect("onDel",self,"_delBuffEff",[eff])

func _delBuffEff(eff):
	if is_instance_valid(eff) :
		eff.queue_free()

func _on_dragK_gui_input(event):
	if sys.isTest && event is InputEventMouseButton && event.pressed && event.button_index == 2:
		chara.plusXp(10)
	pass # Replace with function body.
