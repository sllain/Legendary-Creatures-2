extends Skill

func _data():
	name = "屏气凝神"
	cd = 5
	tab = "射手"

func _cast():
	#mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	#yield(ctime(0.4),"timeout")
	masCha.castBuff(masCha,"b_a_jiSu",per(20))

func getDec():
	return tr("获得%d层急速，无施法动作") % [per(20)]
