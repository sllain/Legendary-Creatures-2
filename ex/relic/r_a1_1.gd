extends Relic

func _data():
	name = "狂战之姿"
	
func getDec():
	return tr("战士每损失10%%的生命值获得%d%%的增伤") % [lvPer(lv,9)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.hasTab("战士"):
		atkInfo.per += lvPer(lv,0.9) * (atkInfo.castCha.hp / atkInfo.castCha.maxHp )
