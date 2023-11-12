extends Csb

func _data():
	name = "闪电球卷轴"
	lock = 0

func getDec():
	return tr("对敌方法强最高的单位造成%d点伤害，附加20层麻痹") % lvPer(lv,500)

func _use():
	var tCha = null
	for cha in sys.batScene.getAllChas():
		if cha.team == sys.player.team:continue
		if tCha == null:
			tCha = cha
			continue
		if tCha.matk < cha.matk :
			tCha = cha
	if tCha != null:
		sys.batScene.newEff("e_shanDianQiu",tCha.position,tCha.imgCenterPos)
		tCha.hurt(tCha,lvPer(lv,500),HURTTYPE.MAG)
		tCha.castBuff(tCha,"b_b_maBi",20)
