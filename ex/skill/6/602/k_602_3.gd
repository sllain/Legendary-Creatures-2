extends Skill

func _data():
	name = "诡异雾气"
	cd = 8
	tab = "萨满"
	
func getDec():
	return tr("对目标1格造成%d%%的魔法伤害，使他们负面状态加%d层") % [per(1.5) * 100,per(15)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = masCha.scene.newEff("e_guiYiWuQi", masCha.aiCha.position, masCha.aiCha.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team != mas.team:
			hurtPerM(i,per(1.5))
			for j in i.affs :
				if j.hasTab("deBuff") :
					j.lv += 15
