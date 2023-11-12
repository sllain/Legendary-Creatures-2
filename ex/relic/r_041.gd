extends Relic

func _data():
	name = "狂暴之刃"
	
func getDec():
	return tr("全队暴击时伤害提升%d%%") % [lvPer(lv,20)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.isCri:
		atkInfo.per += lvPer(lv,0.20)
