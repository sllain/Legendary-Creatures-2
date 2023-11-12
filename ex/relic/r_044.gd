extends Relic

func _data():
	name = "开路先锋"
	
func getDec():
	return tr("进入敌方区域的单位伤害提升%d%%") % [lvPer(lv,15)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.cell.x > 4:
		atkInfo.per += lvPer(lv,0.15)
