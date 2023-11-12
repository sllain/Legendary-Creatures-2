extends Skill

func _data():
	name = "冰结"
	cd = 9
	tab = "专属"
	
func getDec():
	return tr("对敌方最虚弱的单位造成%d%%的魔法伤害附加%d眩晕，而他周围敌人受到%d%%的魔法伤害附加%d层结霜") % [per(2.0) * 100,10,per(1.5)*100,per(10)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var cha = masCha.getMinAttCha("maxHp",1)
	if cha != null:
		var eff = mas.scene.newEff("e_bingCi", cha.position, cha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		hurtPerM(cha,lvPer(lv,2.0))
		masCha.castBuff(cha,"b_b_xuanYun",5)
		for i in masCha.scene.getCellChas(cha.cell):
			if i.team != mas.team :
				hurtPerM(i,per(1.5))
				masCha.castBuff(i,"b_b_jieShuang",per(10))
	
