extends Skill

func _data():
	name = "圆舞飞刃"
	cd = 7
	tab = "专属"
			
func getDec():
	return tr("对敌方物理攻击最高的单位造成%d%%的物理伤害，对魔法攻击最高的单位造成%d%%的魔法伤害") % [per(1.3)*100,per(0.8)*100]

func _cast():
	var cha = masCha.getMaxAttCha("atk",1)
	if cha != null:
		var eff = mas.scene.newEff("e_bingCi", cha.position, cha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		hurtPerP(cha,lvPer(lv,1.3))
	
	cha = masCha.getMaxAttCha("matk",1)
	if cha != null:
		var eff = mas.scene.newEff("e_bingCi", cha.position, cha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		hurtPerM(cha,lvPer(lv,0.8))
