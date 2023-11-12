extends Skill

func _data():
	name = "罡气崩拳"
	cd = 10
	tab = "专属"
	
func getDec():
	return tr("消除自身增益状态，对目标1格敌人造成%d%%的物理攻击的真实伤害，每5层增益状态，使该伤害提高%d%%") %  [per(0.9)*100,40]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_hanDi",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	var p = 1.0
	for i in masCha.affs:
		if i is Buff && i.hasTab("buff") && i.lv > 0:
			p += (i.lv / 5 ) * 0.4
			i.del()

	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team != mas.team:
			hurtPer(i,per(0.9) * p,HURTTYPE.REAL)
