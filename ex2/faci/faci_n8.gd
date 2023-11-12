extends Faci

func _data():
	isCs = true
	isPressed = true
	name = "智者点拨"
	dec = "使你的一个单位获得2点技能点"
	weight = 0.5
	tab = "world"
	num = 3
	lockType = 1
	lock = 0
	achDec = "通关难度8"

func _in():
	lv = 0

var g = 800

func _trig():
	sys.eventDlg.txt("%s" % [dec],true)
	var inx = yield(sys.eventDlg.selBB([tr("花费 %d 金币 点拨一个单位") % g,tr("离开")]),"onSel")
	if inx == 0 :
		if sys.player.subItem("m_gold",g) :
			var dlg = sys.newDlg("res://tscn/chara/selChaDlg.tscn")
			dlg.init(sys.player.team)
			dlg.connect("onSel",self,"_r")
		else:
			sys.eventDlg.txt("金币 不足")
		
func _r(cha:Chara):
	del()
	cha.sp += 2
	sys.eventDlg.txt(tr("%s 获得了%d个技能点") % [tr(cha.name),2])
		
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 8 :
		achCom()

