extends Skill

func _data():
	name = "闪电球"
	cd = 6
	tab = "雷法"
	
func getDec():
	return tr("对敌方法强最高的单位造成%d%%的魔法伤害，附加%d层麻痹") % [per(0.7)*100,per(10)]

func _cast():
	var cha = masCha.getMaxAttCha("matk",1)
	if cha != null:
		mas.playAnim("buff")
		yield(ctime(0.3),"timeout")
		r(cha)
#		var eff:Eff = mas.scene.newEff("e_shanDianQiu",mas.position,mas.imgCenterPos)
#		eff.modulate = Color("#8c35ff")
#		eff.flyToChara(cha, 550)
#		eff.connect("onReach",self,"r")
		
func r(cha):
	var eff:Eff = mas.scene.newEff("e_shanDianQiu",cha.position,cha.imgCenterPos)
	hurtPerM(cha,per(0.7))
	masCha.castBuff(cha,"b_b_maBi",per(10))

