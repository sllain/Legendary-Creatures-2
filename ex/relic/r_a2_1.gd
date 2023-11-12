extends Relic

func _data():
	name = "穿透攻击"
	
func getDec():
	return tr("射手对拥有护盾的单位伤害提升%d%%") % [lvPer(lv,30)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.hasTab("射手") && atkInfo.cha.ward > 0:
		atkInfo.per += lvPer(lv,0.3)
