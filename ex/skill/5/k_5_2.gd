extends Skill

func _data():
	name = "巫毒飞弹"
	cd = 8
	tab = "法师"
	
func getDec():
	return tr("对最近%d个敌人造成%d%%的魔法伤害，附加%d层中毒") % [4,per(1.4) * 100,per(10)]

func _cast():
	mas.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	for cha in  masCha.getMinRanChas(1,4):
		var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
		eff.get_node("up/img").frame = 3
		eff.flyToChara(cha,300)
		eff.connect("onReach",self,"r",[cha])

func r(cha):
	hurtPer(cha,per(1.4),HURTTYPE.MAG)
	masCha.castBuff(cha,"b_b_zhongDu",per(10))
