extends Skill

func _data():
	name = "气聚丹田"
	cd = 5
	tab = "格斗家"

func _cast():
	#mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	#yield(ctime(0.4),"timeout")
	for j in masCha.affs :
		if j.hasTab("deBuff") :
			j.del()
	var n = 10
	masCha.castBuff(masCha,"b_a_kuangNu",per(n))
	masCha.castBuff(masCha,"b_a_diYu",per(n))
	masCha.castBuff(masCha,"b_a_jiSu",per(n))
	masCha.castBuff(masCha,"b_a_chaoRan",per(n))

func getDec():
	return tr("净化自身的负面状态，并获得%d层 狂怒，抵御，急速，超然") % [per(10)]
