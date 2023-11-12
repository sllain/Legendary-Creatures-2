extends Skill

func _data():
	name = "勇武"
	cd = 5
	tab = "战士"

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	masCha.castBuff(masCha,"b_a_kuangNu",per(15))
	masCha.castBuff(masCha,"b_a_diYu",per(15))
	masCha.castBuff(masCha,"b_a_chaoRan",per(15))

func getDec():
	return tr("获得%d层狂怒，抵御和超然，无施法动作") % [per(15)]

