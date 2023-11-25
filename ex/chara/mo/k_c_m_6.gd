extends Skill

func _data():
	name = "毒雾"
	cd = 13
	tab = "专属"
func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var cell = sys.batScene.getEnemyCenterCell(masCha.team)
	# sys.batScene.newEff("e_yunShi",sys.batScene.map_to_world(cell))
	# yield(ctime(0.4),"timeout")

	var eff = masCha.scene.newEff("e_guiYiWuQi", sys.batScene.map_to_world(cell), Vector2(0, -20))
	eff.scale = Vector2(1.8, 1.8)
	yield(ctime(0.1),"timeout")

	for c in sys.batScene.getCellChas(cell,2):
		if c.team != masCha.team :
			hurtPerM(c,per(0.8))
			masCha.castBuff(c,"b_b_zhongDu",per(10))
		else:
			plusHp(per(0.4) * masCha.matk,c)

func getDec():
	return tr("打击2格范围敌人，造成%d%%魔法伤害，附加%d层中毒。而范围内友军则回复%d%%魔法攻击的生命值") % [per(70),per(10),per(35)]
