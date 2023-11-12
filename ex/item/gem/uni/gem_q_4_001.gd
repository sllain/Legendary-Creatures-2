extends GemUn

func _data():
	name = "闪光石"
	tab = "刺客"
	isUnique = true

func getDec():
	return tr("开场时闪现至敌方后排，获得%d层急速") % per(5)

func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	masCha.castBuff(masCha,"b_a_jiSu",per(5))
	var cell = masCha.cell
	if masCha.team == sys.player.team :
		cell.x = 9
		masCha.castBuff(masCha,"b_a_yinShen",5)
	else:
		cell.x = 0
	masCha.matMoveUp(cell)
	masCha.aiCha = null
