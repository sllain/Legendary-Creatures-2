extends Skill

func _data():
	name = "五雷轰顶"
	cd = 12
	tab = "雷法"
	
func getDec():
	return tr("召唤%d次落雷，对随机敌人造成%d%%的魔法伤害，附加%d层麻痹，落雷能够击中重复目标") % [5,per(1.1)*100,per(10)]

func _cast():
	mas.playAnim("buff")
	yield(ctime(0.3),"timeout")
	for k in 5 :
		var chas = []
		for i in sys.batScene.getAllChas():
			if i.team != masCha.team and i.isDeath == false:
				chas.append(i)
		var cha :Chara= rndListItem(chas)
		if cha == null: return
		sys.batScene.newEff("e_leiDian",cha.position,cha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		hurtPerM(cha,per(1.1))
		masCha.castBuff(cha,"b_b_maBi",per(10))
		yield(ctime(0.2),"timeout")


