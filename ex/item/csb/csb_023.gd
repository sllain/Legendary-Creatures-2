extends Csb

func _data():
	name = "冰刺卷轴"

func getDec():
	return tr("对敌方攻速最高的单位造成%d点伤害，附加20层结霜") % lvPer(lv,500)

func _use():
	var tCha = null
	for cha in sys.batScene.getAllChas():
		if cha.team == sys.player.team:continue
		if tCha == null:
			tCha = cha
			continue
		if tCha.spd < cha.spd :
			tCha = cha
	if tCha != null:
		sys.batScene.newEff("e_bingCi",tCha.position,tCha.imgCenterPos)
		tCha.hurt(tCha,lvPer(lv,500),HURTTYPE.MAG)
		tCha.castBuff(tCha,"b_b_jieShuang",20)
