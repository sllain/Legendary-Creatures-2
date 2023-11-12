extends Skill

func _data():
	name = "等价交换"
	cd = 8
	tab = "炼金术士"
	
func getDec():
	return tr("消除最虚弱友方一半的增益状态，每5层增益使他回复%d%%魔法攻击的生命值") % [per(1.3) * 100]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var xcha = masCha.getWeakCha(2)
	if xcha != null	:
		var p = 0
		for i in masCha.affs:
			if i is Buff && i.hasTab("buff") && i.lv > 0:
				var l = i.lv * 0.5
				p += (l / 5 ) * per(1.3)
				i -= l
		if p <= 0 :return
		var eff = mas.scene.newEff("e_zhiLiaoShu", xcha.position, xcha.imgCenterPos)
		yield(ctime(0.1),"timeout")
		masCha.plusHp(masCha.matk * p,xcha)



