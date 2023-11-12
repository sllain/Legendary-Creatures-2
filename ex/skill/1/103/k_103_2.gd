extends Skill

func _data():
	name = "嗜血一击"
	cd = 6
	tab = "狂战士"
	
func getDec():
	return tr("对目标单位造成%d%%的物理伤害，自身恢复该伤害等量的生命值") %  [per(2.5)*100]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_zhongPi",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	var atkInfo = hurtPer(masCha.aiCha,per(2.5))
	masCha.plusHp(atkInfo.finalVal)
