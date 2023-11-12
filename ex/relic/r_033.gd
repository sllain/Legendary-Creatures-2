extends Relic

func _data():
	name = "吸血獠牙"
	
func getDec():
	return tr("全队获得%d%%普攻吸血") % [lvPer(lv,5)]
	
func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.atkType == ATKTYPE.NORMAL:
		atkInfo.castCha.plusHp(atkInfo.finalVal * lvPer(lv,0.05))
