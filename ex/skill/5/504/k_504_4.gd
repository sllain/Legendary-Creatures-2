extends Skill

func _data():
	name = "晶矛投射"
	cd = 8
	tab = "魔武者"
	
func getDec():
	return tr("对最近3个敌人造成%d%%的魔法伤害和物理伤害,并获得%d%%该伤害值的护盾") % [per(1.0) * 100,70]

func _cast():
	mas.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	for cha in masCha.getMinRanChas(1,3):
		var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
		eff.get_node("up/img").frame = 3
		eff.flyToChara(cha,300)
		eff.connect("onReach",self,"r",[cha])

func r(cha):
	var w = 0
	var info = hurtPer(cha,per(1.0),HURTTYPE.MAG)
	if info != null:
		w += info.finalVal
	info = hurtPer(cha,per(1.0),HURTTYPE.PHY)
	if info != null:
		w += info.finalVal
	plusWard(w * 0.7)
