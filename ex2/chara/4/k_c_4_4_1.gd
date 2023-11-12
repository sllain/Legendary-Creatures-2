extends Skill

func _data():
	name = "出其不意"
	cd = 0
	tab = "专属"

func getDec():
	return tr("闪现敌方后排，并且获得%d层隐身") % per(20)

func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	var cell = masCha.cell
	if masCha.team == sys.player.team :
		cell.x = 9
	else:
		cell.x = 0
	masCha.matMoveUp(cell)
	masCha.aiCha = null
	masCha.castBuff(masCha,"b_a_yinShen",per(20))
