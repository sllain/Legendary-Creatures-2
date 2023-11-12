extends Skill

func _data():
	name = "怒放挥击"
	cd = 7
	tab = "专属"
	
func getDec():
	return tr("对目标1格敌人造成%d%%的伤害，每损失10%%的生命值伤害提高10%%") %  [per(1.3)*100]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_hanDi",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team != mas.team:
			hurtPer(i,per(1.3) * (1 + masCha.hp / masCha.maxHp))
