extends Skill

func _data():
	name = "处决"
	cd = 7
	tab = "刺客"
	
func getDec():
	return tr("造成%d%%物理伤害，目标每损失10%%的生命值，伤害提升10%%") %  [per(2.0) * 100]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_chuJue", mas.aiCha.position, mas.aiCha.imgCenterPos)
	yield(ctime(0.1),"timeout")
	hurt(masCha.aiCha,per(2.0)*masCha.atk * (1 + (1 - masCha.aiCha.hp / masCha.aiCha.maxHp)))
