extends Relic

func _data():
	name = "吟游者"
	
func getDec():
	return tr("辅助对友方施加的增益层数+%d") % [lvPer(lv,5)]

func _in():
	sys.game.connect("onChaCastBuff",self,"r")

func r(bf):
	if bf.castCha.team == sys.player.team and bf.castCha.hasTab("辅助") :
		if bf.hasTab("buff"):
			bf.lv += lvPer(lv,5)
