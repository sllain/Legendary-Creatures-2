extends Skill

func _data():
	name = "火球术"
	cd = 6
	tab = "火法"
	
func getDec():
	return tr("对目标造成%d%%的魔法伤害，附加%d层烧灼") % [per(1.5) * 100,per(10)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var cha = masCha.aiCha
	if cha != null && cha.team != masCha.team:
		var eff:Eff = mas.scene.newEff("e_huoQiu",mas.position,mas.imgCenterPos)
		eff.flyToChara(cha,300)
		eff.connect("onReach",self,"r",[cha])

func r(cha):
	hurtPerM(cha,per(1.5))
	masCha.castBuff(cha,"b_b_shaoZhuo",per(10))


