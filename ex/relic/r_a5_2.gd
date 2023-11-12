extends Relic

func _data():
	name = "元素失控"
	
func getDec():
	return tr("法师的技能伤害，附加%d层随机 烧灼，结霜，麻痹") % [lvPer(lv,5)]

func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.atkType == ATKTYPE.SKILL && atkInfo.castCha.hasTab("法师"):
		var n = rndRan(1,3)
		var id = ""
		if n == 1 :
			id = "b_b_shaoZhuo"
		elif n == 2 :
			id = "b_b_jieShuang"
		else:
			id = "b_b_maBi"
		atkInfo.castCha.castBuff(atkInfo.cha,id,lvPer(lv,5))
