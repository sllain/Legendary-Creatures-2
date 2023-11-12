extends Relic

func _data():
	name = "蛮族之力"
	
func getDec():
	return tr("全队物理伤害提升%d%%") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.hurtType == HURTTYPE.PHY:
		atkInfo.per += lvPer(lv,0.1)
