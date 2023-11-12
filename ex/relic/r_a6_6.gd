extends Relic

func _data():
	name = "伤痛转移"
	lock = 0
	
func getDec():
	return tr("辅助造成伤害时，治疗最虚弱友军%d%%该伤害值的生命值") % [lvPer(lv,30)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha == sys.player.team and atkInfo.castCha.hasTab("辅助"):
		var cha = atkInfo.castCha.getWeakCha(2)
		if cha != null:
			atkInfo.castCha.plusHp(lvPer(lv,0.3) * atkInfo.finalVal,cha)
