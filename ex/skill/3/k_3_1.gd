extends Skill

func _data():
	name = "咆哮"
	cd = 8
	tab = "坦克"

func getDec():
	return tr("以自身%d%%最大生命值对周围1格敌人造成魔法伤害，并嘲讽他们") % [per(15)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_zhanHou",mas.position,mas.imgCenterPos)
	yield(eff,"onAnimTrig")
	for i in masCha.scene.getCellChas(mas.cell) :
		if i.team != mas.team :
			hurt(i,masCha.maxHp * per(0.15),HURTTYPE.MAG)
			i.aiCha = masCha
