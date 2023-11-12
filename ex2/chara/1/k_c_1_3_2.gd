extends Skill

func _data():
	name = "撕咬"
	cd = 8
	tab = "专属"
	
func getDec():
	return tr("造成%d%%物理伤害，治疗%d%%物理攻击的生命值，每损失10%%生命值，治疗量提高10%%") %  [per(2.0) * 100,per(60)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = masCha.scene.newEff("e_ziSeZhuaJi", masCha.aiCha.position, masCha.aiCha.imgCenterPos)
	yield(ctime(0.1),"timeout")
	hurtPer(masCha.aiCha,per(2.0))
	masCha.plusHp(masCha.atk * per(0.6) * (1 + (masCha.hp / masCha.maxHp)))
