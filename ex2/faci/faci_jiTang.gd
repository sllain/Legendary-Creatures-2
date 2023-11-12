extends Faci

func _data():
	isCs = true
	isPressed = true
	name = "祭坛"
	dec = "献祭单位，转化魂值，还能获得不死族单位"
	weight = 0.5
	tab = "world"
	num = 3
#	lockType = 1
#	lock = 0
	achDec = "通关难度1"

func _in():
	lv = 0

func _trig():
	sys.eventDlg.txt("%s" % [dec],true)
	var inx = yield(sys.eventDlg.selBB([tr("选择一个单位"),tr("离开")]),"onSel")
	if inx == 0 :
		var dlg = sys.newDlg("res://tscn/chara/selChaDlg.tscn")
		dlg.init(sys.player.team)
		dlg.connect("onSel",self,"_r")
		
func _r(cha:Chara):
	del()
	var h = cha.baseXp / 3
	for i in cha.lv - 1:
		h += cha.baseXp * pow(3,i)
	var itemPck = ItemPck.new()
	itemPck.addItem(data.newBase("m_xp").setNum(h))
	for i in cha.eqps.items.size():
		cha.setEqp(null,i)
	sys.eventDlg.items(itemPck)
	sys.player.team.delCha(cha)
	
	if cha.origin.find("祭坛") == -1:
		var cid = "c_s_1"
		if cha.hasTab("射手") :
			cid = "c_s_2" 
		elif cha.hasTab("坦克") :
			cid = "c_s_3" 
		elif cha.hasTab("刺客") :
			cid = "c_s_4" 
		elif cha.hasTab("法师") :
			cid = "c_s_5" 
		elif cha.hasTab("辅助") :
			cid = "c_s_6" 

		var dcha = data.newBase(cid)
		sys.player.addAlterCha(dcha) 
		sys.eventDlg.txt(tr("献祭的单位，变为一个 %s") % tr(dcha.name))
	
	elif cha.name != "鬼魂" :
		var dcha :Chara= data.newBase("c_s_0")
		sys.player.addAlterCha(dcha) 
		sys.eventDlg.txt(tr("献祭的单位，变为一个 %s") % tr(dcha.name))
		var k =data.newBase(cha.skills.items[0].id)
		dcha.skills.addItem(k)
		dcha.exSkills.addItem(k)
		var tab = cha.getProfession()
		if tab == "剑士" :
			tab += " 狂战士"
		elif tab == "弓手" :
			tab += " 弩手"
		elif tab == "盾卫" :
			tab += " 肉霸"
		elif tab == "毒枭" :
			tab += " 暗杀者"
		elif tab == "魔武者" :
			tab += " 火法"
		elif tab == "牧师" :
			tab += " 炼金术士"
		dcha.tab = tab
		dcha.attBase.ran = cha.attBase.ran
		dcha.lv = dcha.lv
		dcha.upSkillsReady()
		
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 1 :
		achCom()

