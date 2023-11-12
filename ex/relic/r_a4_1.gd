extends Relic

func _data():
	name = "暗杀之道"
	
func getDec():
	return tr("对手每损失10%%的生命值刺客就获得%d%%的增伤") % [lvPer(lv,6)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.hasTab("刺客"):
		atkInfo.per += lvPer(lv,0.6) * (1 - atkInfo.cha.hp / atkInfo.cha.maxHp )

