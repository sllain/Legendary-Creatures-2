extends Skill

func _data():
	name = "感染"
	cd = 0
	tab = "专属"
func getDec():
	return tr("杀死敌人时召唤一个丧尸，拥有%d%%的生命值") % per(50)

func _in():
	#sys.game.connect("onBattleStart",self,"r")
	masCha.connect("onKill",self,"r2")
	
func r():
	var cell = masCha.cell
	if masCha.team == sys.player.team :
		cell.x = 9
	else:
		cell.x = 0
	masCha.matMoveUp(cell)
	masCha.aiCha = null

func r2(atkInfo):
	var cha :Chara= masCha.summCopy(masCha)
	cha.hp = masCha.hp * per(0.5)
	cha.plusHp(0)
	cha.delIdAff(id)
