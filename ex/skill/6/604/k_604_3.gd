extends Skill

func _data():
	name = "点金手"
	cd = 0
	tab = "炼金术士"
	
func getDec():
	return tr("敌人死亡时，他身上的每%d层负面状态使你获得%d金币") % [20,per(5)]

func _in():
	sys.game.connect("onChaDeath",self,"r")
	
func r(info):
	if info.cha != null && info.cha.team != masCha.team :
		var p = 0
		for i in info.cha.affs:
			if i is Buff && i.hasTab("deBuff") && i.lv > 0:
				p += i.lv
		if p >= 20 :
			sys.player.items.addItem(data.newBase("m_gold").setNum(p / 20 * per(5)))
