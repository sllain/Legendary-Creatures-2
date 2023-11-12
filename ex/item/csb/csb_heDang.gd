extends Csb

func _data():
	name = "核弹"
	lock = -1
	
func _use():
	var cell = sys.batScene.getEnemyCenterCell(sys.player.team)
	sys.batScene.newEff("e_yunShi",sys.batScene.map_to_world(cell))
	yield(ctime(0.4),"timeout")
	for c in sys.batScene.getAllChas():
		if c.team != sys.player.team :
			c.hurt(c,lvPer(lv,999999),HURTTYPE.REAL)
	
func getDec():
	return tr("造成%d真实伤害") % lvPer(lv,999999)
