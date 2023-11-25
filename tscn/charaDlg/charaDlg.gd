extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = $c/body/anim
var itemGrid:ItemGrid
onready var box = $eqpBox

var cha:Chara
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(cha:Chara):
	for i in cons.attDs:
		if i == "maxHp" :continue
		var at = load("res://tscn/charaDlg/att.tscn").instance()
		$"%attBox".add_child(at)
		at.name = i
		at.init(cha,i)
		at.up(cha[i])
	
	cha.connect("onAttSet",self,"rAtt")
	self.cha = cha
	$"%popLv".init(cha)
	$c/info/hpBar.init(cha)
	cha.connect("onHurt",self,"upHp")
	upHp(null)
	cha.connect("onPlayAnim",self,"rPlayAnim")
	rPlayAnim(cha.nowAnim,1)
	tile.text = cha.name
	tile.set("custom_colors/font_color",Color(cons.colorDs.lvs[cha.lv-1]))
	
	for i in cha.skills.items:
		_addSkill(i,0)
	
	cha.skills.connect("onAddItem",self,"_addSkill")
	cha.connect("onPlusLv",self,"rSetLv")
	cha.connect("onPlusXp",self,"rPlusXp")
	rSetLv()
	anim.init(cha)
	$"%tab".text = cha.trTab()
	sys.addTip($"%tab","影响你升级时随机到的技能")
	$c/info/btnBox.hide()
	$"%btnLvUp".hide()
	if cha.team == null:return
	if cha.team == sys.player.team && cha.isSummon == false:
		$c/info/btnBox.show()
		$"%btnLvUp".show()

	$c/buffs.init(cha)
	cha.connect("onSetSp",self,"_setSp")
	_setSp()
	
	self.itemGrid = cha.eqps
	for i in itemGrid.items:
		var btn = load("res://tscn/charaDlg/eqpBtn.tscn").instance()
		$eqpBox.add_child(btn)
		btn.init(i,ifEqp())
		btn.connect("pressed",self,"eqpPressed",[btn])
		btn.connect("onP",self,"rP",[btn])
		
	self.itemGrid.connect("onUp",self,"up")
	
func _setSp():
	$"%spLab".text = "%s%d" % [tr("技能点："),cha.sp]
		

	
func _addSkill(skill,inx):
	var kBtn = load("res://tscn/charaDlg/skill/skillPan.tscn").instance()
	$"%skillBox".add_child(kBtn)
	kBtn.init(skill,cha)

func rAtt(id):
	if id == "maxHp" :
		upHp(null)
	elif $attK/attBox.has_node(id):
		$attK/attBox.get_node(id).up(cha[id])

func upHp(atkInfo):
	$c/info/hp/Label.text = "%d/%d" % [cha.hp,cha.maxHp]
	
func rPlayAnim(id,spd):
	if anim.frames.has_animation(id) :
		anim.play(id)
	else:
		anim.play("atk")
	anim.speed_scale = spd
	
func rSetLv():
	rPlusXp(0)
	upHp(null)
	
func rPlusXp(val):
	if cha.team == null:return
	$"%xp".text = "%d" % [cha.maxXp]
	$c/info/xp.visible = cha.team == sys.player.team && cha.lv < cha.maxLv 
	
func _input(event):
	if event.is_action_pressed("ui_down") :
		cha.plusXp(15)

func eqpPressed(btn):
	if ifEqp() == false: return
	if btn.item == null:
		changeEqp(btn)
		
func ifEqp():
	return cha.team == sys.player.team
			
func changeEqp(btn):
	var dlg = sys.newDlg("res://tscn/item/selItemDlg.tscn")
	dlg.init(sys.player.items,1)
	var item = yield(dlg,"onSel")  
	if item != null:
		cha.setEqp(item,btn.get_index())
		
func up(inx,item1,item2):
	box.get_child(inx).init(itemGrid.items[inx])
	
func rP(inx,btn):
	if inx == 0 :
		changeEqp(btn)
	elif inx == 1 :
		cha.setEqp(null,btn.get_index())

func _on_newVari_pressed():
	if sys.player.team != cha.team :
		return
	if sys.player.subItem("m_cry",1) :
		sys.eventDlg.selVari(cha)
	else:
		sys.newMsg("晶石 不足")

func _on_btnR_pressed():
	if sys.player.subItem("m_cry",cha.reviveVal) :
		cha.revive()
		$c/info/btnBox/btnR.hide()
	else:
		sys.newMsg("晶石 不足")
#解雇
func _on_btnFire_pressed():
	var g = cha.price * 0.5
	var inx =  yield( sys.eventDlg.selBB([tr("解雇，获得 %d 金币") % g,tr("放弃")]),"onSel") 
	if inx == 0 :
		var itemPck = ItemPck.new()
		itemPck.addItem(data.newBase("m_gold").setNum(g))
		sys.eventDlg.items(itemPck)
		cha.fire()
		del()
	else:
		pass

func _on_btnLvUp_pressed():
	if sys.player.items.hasIdItem("m_xp").num >= cha.maxXp :
		cha.playerPlusLv()
	else:
		sys.newMsg("魂 不足")

func _on_tab_pressed():
	var skills = ItemPck.new()
	for i in data.skills.items:
		if i.hasOrTab(cha.tab) :
			skills.addItem(i)
	var dlg = sys.newDlg("res://tscn/charaDlg/skillShowDlg.tscn")
	dlg.init(skills)
	
