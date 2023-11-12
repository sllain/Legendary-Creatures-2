extends Skill

func _data():
	name = "翔龙摆尾"
	cd = 9
	tab = "格斗家"
	
func getDec():
	return tr("对目标1格敌人造成%d%%的物理伤害，身上每5层增益状态，使该伤害提高%d%%") %  [per(1.3)*100,15]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_hanDi",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	var p = 1
	for i in masCha.affs:
		if i is Buff && i.hasTab("buff") && i.lv > 0:
			p += (i.lv / 5 ) * 0.15
	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team != mas.team:
			hurtPer(i,per(1.3) * p)
