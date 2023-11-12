extends Relic

func _data():
	name = "先知"
	
func getDec():
	return tr("战斗开始时，辅助为最近的2名友军提供%d%%其最大生命值的护盾") % [lvPer(lv,15)]

func _in():
	sys.game.connect("onBattleStart",self,"r")

func r():
	for i in sys.batScene.getAllChas():
		if i.team == sys.player.team and i.hasTab("辅助") :
			var chas = i.getMinRanChas(2,2)
			for k in chas:
				i.plusWard(k.maxHp * lvPer(lv,0.15),k)
