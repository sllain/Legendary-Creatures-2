extends Skill

func _data():
	name = "圣光轰炸"
	cd = 8
	tab = "牧师"
	
func getDec():
	return tr("对目标造成%d%%的魔法伤害，并治疗目标周围1格友军%d%%魔法伤害的生命值") % [per(1.8) * 100,90]

func _cast():
	masCha.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_shengGuang", masCha.aiCha.position, masCha.aiCha.imgCenterPos)
	yield(eff,"onAnimTrig")
	var h = per(1.8) * masCha.matk
	hurt(masCha.aiCha,h,HURTTYPE.MAG,ATKTYPE.SKILL)
	for i in masCha.scene.getCellChas(masCha.aiCha.cell) :
		if i.team == mas.team :
			masCha.plusHp(h * 0.9,i)
