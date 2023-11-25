extends Skill

func _data():
	name = "盾档"
	cd = 6
	tab = "盾卫"

func getDec():
	return tr("获得%d%%最大生命值的护盾值,%d层抵御") % [per(0.20) * 100,per(20)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	masCha.castBuff(masCha,"b_a_diYu",per(20))
	plusWard(masCha.maxHp * per(0.20))


