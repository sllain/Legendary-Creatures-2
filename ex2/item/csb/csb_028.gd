extends Csb

func _data():
	name = "霜雨卷轴"
	lock = 0

func getDec():
	return tr("召唤5波霜雨，每波对1格范围敌人造成%d点魔法伤害附加%d层结霜") % [lvPer(lv,80),5]

func _use():
	var cell = sys.batScene.getEnemyCenterCell(sys.player.team)
	for n in 5:
		sys.batScene.newEff("e_shuangYu",sys.batScene.map_to_world(cell))
		yield(ctime(0.4),"timeout")
		for c in sys.batScene.getCellChas(cell,1):
			if c.team != sys.player.team :
				c.hurt(c,lvPer(lv,80),HURTTYPE.MAG)
				c.castBuff(c,"b_b_jieShuang",5)
