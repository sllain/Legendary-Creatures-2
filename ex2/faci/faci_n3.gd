extends Faci

func _data():
	isCs = true
	isPressed = true
	name = "遗忘之泉"
	dec = "使你的一个单位遗忘所有回到1级，返还魂值"
	weight = 0.5
	tab = "world"
	num = 3
	lockType = 1
	lock = 0
	achDec = "通关难度3"

func _in():
	lv = 0
	
func _trig():
	sys.eventDlg.txt(tr("%s" % [dec]),true)
	var inx = yield(sys.eventDlg.selBB([tr("选择一个单位"),tr("离开")]),"onSel")
	if inx == 0 :
		var dlg = sys.newDlg("res://tscn/chara/selChaDlg.tscn")
		dlg.init(sys.player.team)
		dlg.connect("onSel",self,"_r")
		
func _r(cha:Chara):
	var h = cha.baseXp
	for i in cha.lv - 1:
		h += cha.baseXp * pow(3,i)
	cha.sp = 0
	cha.lv = 1
	cha.upMaxXp()
	for i in range(cha.skills.items.size()-1,-1,-1):
		var k = cha.skills.items[i]
		if i == 0:
			k.lv = 1
		else:cha.skills.items.remove(i)
	for i in cha.exSkills.items:
		i.lv = 1
		cha.skills.addItem(i)
	var itemPck = ItemPck.new()
	itemPck.addItem(data.newBase("m_xp").setNum(h))
	sys.eventDlg.txt(tr("%s 已经遗忘所学技能") % tr(cha.name),true)
	sys.eventDlg.items(itemPck)
	del()
		
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 3 :
		achCom()

