extends Skill

func _data():
	name = "伺机而动"
	cd = 10
	tab = "暗杀者"

func getDec():
	return tr("如果是隐身状态，解除隐身并对周围1格造成%d%%物理伤害，每5层隐身伤害提升%d%%；否则获得%d层隐身") % [per(1.8)*100,40,per(15)]

func _cast():
	if masCha.yingTime > 0:
		var eff = mas.scene.newEff("e_siJiErDong",masCha.position,masCha.imgCenterPos)
		eff.modulate = Color("#7b1c69")
		yield(ctime(0.2),"timeout")
		var p = 1.0
		var bf = masCha.hasAff("b_a_yinShen")
		if bf != null && bf.lv > 0 : 
			p = 1 + bf.lv * 0.2 * 0.4
			bf.del()
		for i in masCha.scene.getCellChas(mas.cell) :
			if i.team != mas.team :
				var aff = mas.scene.newEff("e_anYingTuXi",i.position, i.imgCenterPos)
				yield(ctime(0.1),"timeout")
				hurtPer(i,per(1.8) * p)
	else:
		masCha.castBuff(masCha,"b_a_yinShen",per(15))
