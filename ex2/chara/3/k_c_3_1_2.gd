extends Skill

func _data():
	name = "芒硝护盾"
	cd = 0
	tab = "专属"

func getDec():
	return tr("获得护盾时也会获得一半的治疗效果，且战斗开始时，获得%d%%最大生命值的护盾") % [per(30)]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	masCha.connect("onPlus",self,"r2")

func r():
	plusWard(masCha.maxHp * per(0.3))
	
func r2(info):
	if info.type == "ward" :
		plusHp(info.val * 0.5)
