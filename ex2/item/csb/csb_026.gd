extends Csb

func _data():
	name = "真视卷轴"

func getDec():
	return tr("对敌方所有单位造成%d点魔法伤害，并解除其隐身状态") % lvPer(lv,100)

func _use():
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team == sys.player.team:continue
		sys.batScene.newEff("e_zhenShi",cha.position,cha.imgCenterPos)
		cha.hurt(cha,lvPer(lv,100),HURTTYPE.MAG)
		var bf = cha.hasAff("b_a_yinShen")
		if bf != null:bf.del()
