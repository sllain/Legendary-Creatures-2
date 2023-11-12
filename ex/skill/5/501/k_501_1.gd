extends Skill

func _data():
	name = "冰刺"
	cd = 5
	tab = "冰法"
	
func getDec():
	return tr("对敌方攻速最高的单位造成%d%%的魔法伤害,附加%d层结霜") % [per(0.7) * 100,per(10)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var cha = masCha.getMaxAttCha("spd",1)
	if cha != null:
		var eff = mas.scene.newEff("e_bingCi", cha.position, cha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		hurtPerM(cha,lvPer(lv,0.7))
		masCha.castBuff(cha,"b_b_jieShuang",per(10))

