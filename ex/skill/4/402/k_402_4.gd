extends Skill

func _data():
	name = "毒爆"
	tab = "毒枭"
	cd = 0

func getDec():
	return tr("对敌人附加的中毒达到30层时，消除层数，对目标1格范围造成%d%%的物理伤害") % per(400)

func _in():
	masCha.connect("onCastBuff",self,"r")

func r(buff:Buff):
	if buff.id == "b_b_zhongDu" && buff.lv >= 30:
		var cha = buff.masCha
		if cha == null:return
		var eff = mas.scene.newEff("e_xuanFengZhan", cha.position,cha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		for i in masCha.scene.getCellChas(cha.cell):
			if i.team != mas.team :
				hurtPerP(i,per(4.0),ATKTYPE.EFF)
		buff.lv -= 30

