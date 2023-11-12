extends Csb

func _data():
	name = "灭绝术"
	lock = -1
	tab = "黑店"

func getDec():
	return tr("随机对3名敌人造成%d点真实伤害，目标每有一种异常状态伤害提升50%%") % lvPer(lv,50)

func _use():
	var cs = []
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team == sys.player.team:continue
		cs.append(cha)
	cs.shuffle()
	var num = 0
	for cha in cs:
		var rate = 1.0
		for bf in cha.affs :
			if bf.hasTab("deBuff") :
				rate += 0.5
		sys.batScene.newEff("e_mieJue",cha.position,cha.imgCenterPos)
		cha.hurt(cha,lvPer(lv,50*rate),HURTTYPE.REAL)
		num += 1
		if num >= 3:break
