extends Skill

func _data():
	name = "野性咆哮"
	cd = 6
	tab = "狂战士"

func getDec():
	return tr("对周围1格造成%d%%物理伤害，每命中一名敌人获得%d层狂怒和急速") % [per(1.4)*100,per(8)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_zhanHou",mas.position,mas.imgCenterPos)
	yield(eff,"onAnimTrig")
	for i in masCha.scene.getCellChas(mas.cell) :
		if i.team != mas.team :
			hurtPer(i,per(1.4))
			masCha.castBuff(masCha,"b_a_kuangNu",per(8))
			masCha.castBuff(masCha,"b_a_jiSu",per(8))
