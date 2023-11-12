extends Skill

func _data():
	name = "低吟浅唱"
	cd = 5
	tab = "辅助"

func _cast():
	#mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	#yield(ctime(0.4),"timeout")
	masCha.castBuff(masCha,"b_a_chaoRan",per(20))

func getDec():
	return tr("获得%d层超然，无施法动作") % [per(20)]
