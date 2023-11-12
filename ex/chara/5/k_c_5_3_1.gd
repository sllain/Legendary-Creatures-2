extends Skill

func _data():
	name = "寄生粘液"
	cd = 0
	tab = "专属"

func getDec():
	return tr("战斗开始时，克隆一个自身,但减少%d%%的增伤和减伤") % (lvPer(lv,60,-lvPerVal))
	
func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	if masCha.isSummon :return
	var cha :Chara= masCha.summCopy(masCha,null,lvPer(lv,60,-lvPerVal))
	cha.hp = masCha.hp
	cha.plusHp(0)
		
func delAllConnect():
	.delAllConnect()
