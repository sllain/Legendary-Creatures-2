extends Skill

func _data():
	name = "威能凝聚"
	cd = 5
	tab = "法师"

func _cast():
	#mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	#yield(ctime(0.4),"timeout")
	masCha.castBuff(masCha,"b_a_weiNeng",per(20))

func getDec():
	return tr("获得%d层威能，无施法动作") % [per(20)]
