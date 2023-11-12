extends Csb

func _data():
	name = "毒雾卷轴"
	lock = 0

func getDec():
	return tr("召唤毒雾对2格范围敌人造成%d点魔法伤害，附加%d层中毒") % [lvPer(lv,300),20]

func _use():
	var cell = sys.batScene.getEnemyCenterCell(sys.player.team)
	sys.batScene.newEff("e_duWu",sys.batScene.map_to_world(cell))
	yield(ctime(0.3),"timeout")
	for c in sys.batScene.getCellChas(cell,2):
		if c.team != sys.player.team :
			c.hurt(c,lvPer(lv,300),HURTTYPE.MAG)
			c.castBuff(c,"b_b_zhongDu",20)

