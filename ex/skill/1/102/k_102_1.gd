extends Skill

func _data():
	name = "撼地"
	cd = 8
	tab = "钝器使"
	
func getDec():
	return tr("对目标单位造成%d%%的物理伤害，并对其周围1格其他单位造成%d%%伤害，附加%d层破甲") %  [per(2.0) * 100,per(1.2) * 100,per(10)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_hanDi",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	hurtPer(masCha.aiCha,per(1.6))
	masCha.castBuff(masCha.aiCha,"b_b_poJia",per(10))
	# masCha.aiCha.playAnim("hit2")
	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team != mas.team && i != masCha.aiCha:
			hurtPer(i,per(1.0))
			masCha.castBuff(i,"b_b_poJia",per(10))
			# i.playAnim("hit2")
