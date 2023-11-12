extends Relic

func _data():
	name = "用毒高手"
	
func getDec():
	return tr("刺客技能造成伤害时，附加%d层中毒") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.atkType == ATKTYPE.SKILL && atkInfo.castCha.hasTab("刺客"):
		atkInfo.castCha.castBuff(atkInfo.cha,"b_b_zhongDu",lvPer(lv,10))

