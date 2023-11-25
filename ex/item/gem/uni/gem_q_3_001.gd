extends GemUn

func _data():
	name = "盾石"
	tab = "坦克"
	isUnique = true
	
func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	plusWard(masCha.maxHp * per(0.15))
	
func getDec():
	return tr("战斗开始时，获得%d%%最大生命值的护盾") % [per(15)]
