extends Skill

func _data():
	name = "无极剑道"
	cd = 0
	tab = "专属"

func getDec():
	return tr("闪现敌方后排，普攻永久附带%d%%攻击力的真实伤害") % per(25)

func _in():
	sys.game.connect("onBattleStart",self,"r")
	masCha.connect("onCastHurt",self,"r2")
	
func r():
	var cell = masCha.cell
	if masCha.team == sys.player.team :
		cell.x = 9
	else:
		cell.x = 0
	masCha.matMoveUp(cell)
	masCha.aiCha = null
	
func r2(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		hurt(atkInfo.cha,masCha.atk * per(0.25),HURTTYPE.REAL,ATKTYPE.EFF)
