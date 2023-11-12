extends Csb

func _data():
	name = "巨镰卷轴"
	lock = 0

func getDec():
	return tr("对1格范围敌人造成%d点物理伤害，附加%d层流血") % [lvPer(lv,500),20]

func _use():
	var cell = sys.batScene.getEnemyCenterCell(sys.player.team)
	sys.batScene.newEff("e_juLian",sys.batScene.map_to_world(cell))
	yield(ctime(0.4),"timeout")
	for c in sys.batScene.getCellChas(cell,1):
		if c.team != sys.player.team :
			c.hurt(c,lvPer(lv,500),HURTTYPE.PHY)
			c.castBuff(c,"b_b_liuXue",20)

