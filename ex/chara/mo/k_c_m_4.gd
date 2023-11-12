extends Skill

func _data():
	name = "阎罗刀刃"
	cd = 0
	tab = "专属"
func getDec():
	return tr("闪现敌方后排，普攻暴击时额外造成%d%%攻击力的真实伤害") % per(70)

func _in():
	sys.game.connect("onBattleStart",self,"r")
	masCha.connect("onCastHurt",self,"r3")
	
func r():
	var cell = masCha.cell
	if masCha.team == sys.player.team :
		cell.x = 9
	else:
		cell.x = 0
	masCha.matMoveUp(cell)
	masCha.aiCha = null
	
func r3(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL and atkInfo.isCri :
		hurt(atkInfo.cha,masCha.atk * per(0.7),HURTTYPE.REAL,ATKTYPE.EFF)
		

