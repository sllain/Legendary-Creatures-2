extends Skill

func _data():
	name = "冰弹"
	cd = 7
	tab = "专属"

func getDec():
	return tr("对最近3个敌人造成%d%%的魔法伤害，附加%d层结霜") % [per(1.3) * 100,per(10)]

func _cast():
	mas.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	for cha in  masCha.getMinRanChas(1,3) :
		var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
		eff.get_node("up/img").frame = 4
		eff.flyToChara(cha,300)
		eff.connect("onReach",self,"r",[cha])

func r(cha):
	hurtPer(cha,per(1.3),HURTTYPE.MAG)
	masCha.castBuff(cha,"b_b_jieShuang",per(10))
