extends Skill

func _data():
	name = "碎星一击"
	cd = 11
	tab = "专属"

func getDec():
	return tr("对目标1格造成%d%%的物理伤害，附加10%%目标最大生命值的物理伤害，%d层流血") %  [per(1.8) * 100,per(10)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_hanDi",masCha.aiCha.position, masCha.aiCha.imgCenterPos)
	# masCha.aiCha.playAnim("hit2")
	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team != mas.team :
			hurt(i,masCha.atk * per(1.8) + i.maxHp * 0.1)
			masCha.castBuff(i,"b_b_liuXue",per(10))
			# i.playAnim("hit2")

