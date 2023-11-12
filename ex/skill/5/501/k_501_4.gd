extends Skill

func _data():
	name = "霜雨"
	cd = 15
	tab = "冰法"

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var cell = sys.batScene.getEnemyCenterCell(masCha.team)
	for i in per(5):
		sys.batScene.newEff("e_shuangYu",sys.batScene.map_to_world(cell))
		yield(ctime(0.2),"timeout")
		if is_instance_valid(sys.batScene) == false :return
		for c in sys.batScene.getCellChas(cell,1):
			if c.team != masCha.team :
				hurtPerM(c,0.3)
				masCha.castBuff(c,"b_b_jieShuang",3)
		yield(ctime(0.2),"timeout")

func getDec():
	return tr("召唤%d波霜雨，每波造成1格范围敌人30%%魔法伤害，附加3层结霜") % [per(5)]
