extends Skill

func _data():
	name = "焰旋"
	cd = 8
	tab = "专属"

func getDec():
	return tr("对目标一格敌人造成%d%%的魔法伤害附加%d层烧灼，中心敌人额外受到%d%%的最大生命值的魔法伤害") % [per(1.4) * 100,per(10),10]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	if masCha.aiCha == null:return
	var eff = masCha.scene.newEff("e_yanXuan", masCha.aiCha.position)
	for i in masCha.scene.getCellChas(masCha.aiCha.cell):
		if i.team != mas.team :
			hurtPerM(i,per(1.4))
			masCha.castBuff(i,"b_b_shaoZhuo",per(10))
	hurt(masCha.aiCha,masCha.aiCha.maxHp * per(0.1),HURTTYPE.MAG)
