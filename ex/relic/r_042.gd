extends Relic

func _data():
	name = "辉能之源"
	
func getDec():
	return tr("全队魔法伤害提升%d%%") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.hurtType == HURTTYPE.MAG :
		atkInfo.per += lvPer(lv,0.1)
 
