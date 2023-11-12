extends Relic

func _data():
	name = "光辉信仰"
	
func getDec():
	return tr("辅助施加的治疗和护盾效果提升%d%%") % [lvPer(lv,12)]

func _in():
	sys.game.connect("onChaCastPlusStart",self,"r")

func r(info):
	if info.castCha.team == sys.player.team && info.castCha.hasTab("辅助"):
		info.per += lvPer(lv,0.12)	
