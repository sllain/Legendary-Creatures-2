extends Csb

func _data():
	name = "陨石卷轴"
	lock = 0
	
func _use():
	var cell = sys.batScene.getEnemyCenterCell(sys.player.team)
	sys.batScene.newEff("e_yunShi",sys.batScene.map_to_world(cell))
	yield(ctime(0.4),"timeout")
	for c in sys.batScene.getCellChas(cell,2):
		if c.team != sys.player.team :
			c.hurt(c,lvPer(lv,250),HURTTYPE.MAG)
			c.castBuff(c,"b_b_shaoZhuo",20)
	
func getDec():
	return tr("召唤陨石打击敌人，造成%d魔法伤害，附加20层烧灼") % lvPer(lv,250)
