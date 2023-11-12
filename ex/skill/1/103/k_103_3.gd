extends Skill

func _data():
	name = "狂放重击"
	cd = 9
	tab = "狂战士"
	
func getDec():
	return tr("对自身造成5%%的当前生命值的真实伤害，对目标1格敌人造成%d%%的物理攻击的真实伤害") %  [per(1.3)*100]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_hanDi",masCha.aiCha.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	hurt(masCha,masCha.hp * 0.05,HURTTYPE.REAL,ATKTYPE.EFF)
	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team != mas.team:
			hurt(i,masCha.atk * per(1.3),HURTTYPE.REAL)
