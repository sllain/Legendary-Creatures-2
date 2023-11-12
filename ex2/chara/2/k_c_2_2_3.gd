extends Skill

func _data():
	name = "超声波"
	cd = 10
	tab = "专属"

func getDec():
	return tr("对目标造成%d次%d%%的物理伤害触发攻击特效，攻速会提高施放速度") % [per(5),per(70)]

func _cast():
	mas.playAnim("atk2",masCha.spd)
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3/masCha.spd),"timeout")
	for i in per(5):
		var cha = masCha.aiCha
		if cha != null && cha.team != masCha.team:
			var eff:Eff = mas.scene.newEff("e_atk1",mas.position,mas.imgCenterPos)
			eff.get_node("up/img").frame = 3
			eff.flyToChara(cha,700)
			eff.connect("onReach",self,"r",[cha])
			yield(ctime(0.1),"timeout")

func r(cha):
	hurtPer(cha,per(0.7),HURTTYPE.PHY,ATKTYPE.NORMAL)

