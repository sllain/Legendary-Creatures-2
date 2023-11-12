extends Csb

func _data():
	name = "雷电卷轴"
	
func _use():
	for i in 5 :
		var cs = []
		for cha in sys.batScene.getAllChas():
			if cha.team != sys.player.team && cha.isDeath == false:
				cs.append(cha)
		var c :Chara= rndListItem(cs)
		if c == null: return
		sys.batScene.newEff("e_leiDian",c.position)
		yield(ctime(0.1),"timeout")
		c.hurt(c,lvPer(lv,200),HURTTYPE.MAG)
		c.castBuff(c,"b_b_maBi",20)
		yield(ctime(0.2),"timeout")

func getDec():
	return tr("召唤5道闪电攻击随机敌人，每次造成%d魔法伤害 并附加20层麻痹") % lvPer(lv,200)
