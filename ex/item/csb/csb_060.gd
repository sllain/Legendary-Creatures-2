extends Csb

func _data():
	name = "混元弹"
	lock = -1
	tab = "黑店"

func getDec():
	return tr("对所有敌方造成%d点真实伤害") % lvPer(lv,200)

func _use():
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team == sys.player.team:continue
		sys.batScene.newEff("e_hunYuanDan",cha.position,cha.imgCenterPos)
		cha.hurt(cha,lvPer(lv,200),HURTTYPE.REAL)
