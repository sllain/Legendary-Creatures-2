extends Skill

func _data():
	name = "奇袭"
	cd = 0
	tab = "专属"

func getDec():
	return tr("开场时闪现至敌方后排，获得%d层急速和狂怒，且前2次攻击必定造成暴击") % per(20)

func _in():
	sys.game.connect("onBattleStart",self,"r")
	masCha.connect("onCastHurtStart",self,"r2")
	atkN = 0
	
func r():
	masCha.castBuff(masCha,"b_a_jiSu",per(20))
	masCha.castBuff(masCha,"b_a_kuangNu",per(20))
	var cell = masCha.cell
	if masCha.team == sys.player.team :
		cell.x = 9
	else:
		cell.x = 0
	masCha.matMoveUp(cell)
	masCha.aiCha = null

var atkN = 0
func r2(atkInfo):
	if atkN < 2 && atkInfo.atkType == ATKTYPE.NORMAL :
		atkInfo.isCri = true
		atkN += 1
