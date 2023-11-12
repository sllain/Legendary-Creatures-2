extends Csb

func _data():
	name = "震击卷轴"
	lock = 0

func getDec():
	return tr("对敌方攻击力最高的敌人造成%d点物理伤害，并眩晕%d秒") % [lvPer(lv,500),2]

func _use():
	var tCha = null
	for cha in sys.batScene.getAllChas():
		if cha.team == sys.player.team:continue
		if tCha == null:
			tCha = cha
			continue
		if tCha.atk < cha.atk :
			tCha = cha
	if tCha != null:
		sys.batScene.newEff("e_zhenJi",tCha.position,tCha.imgCenterPos)
		tCha.hurt(tCha,lvPer(lv,500),HURTTYPE.PHY)
		tCha.castBuff(tCha,"b_b_xuanYun",20)

