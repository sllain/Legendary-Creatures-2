extends Skill

func _data():
	name = "霸王斩"
	cd = 10
	tab = "剑士"
	
func _in():
	masCha.connect("onNormAtk",self,"r")
	
func getDec():
	return tr("对目标1格造成%d%%物理伤害,每次攻击减少20%%冷却,附加%d层流血") % [per(170),per(10)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_baWangZhan",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.5),"timeout")
	if masCha.aiCha != null:
		for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
			if i.team != mas.team :
				hurtPer(i,per(1.7))
				masCha.castBuff(i,"b_b_liuXue",per(10))

func r():
	cdVal += cd * 0.2
