extends Skill

func _data():
	name = "陨石术"
	cd = 13
	tab = "火法"

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var cell = sys.batScene.getEnemyCenterCell(masCha.team)
	sys.batScene.newEff("e_yunShi",sys.batScene.map_to_world(cell))
	yield(ctime(0.4),"timeout")
	for c in sys.batScene.getCellChas(cell,2):
		if c.team != masCha.team :
			hurtPerM(c,per(1.1))
			masCha.castBuff(c,"b_b_shaoZhuo",per(10))

func getDec():
	return tr("召唤陨石打击2格范围敌人，造成%d%%魔法伤害，附加10层烧灼") % [per(110)]

