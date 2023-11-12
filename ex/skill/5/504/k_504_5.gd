extends Skill

func _data():
	name = "辉能斩"
	cd = 9
	tab = "魔武者"
	
func getDec():
	return tr("对目标1格敌人造成%d%%的物理伤害和魔法伤害") %  [per(1.6)*100]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_baWangZhan",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team != mas.team:
			hurtPerP(i,per(1.6))
			hurtPerM(i,per(1.6))
