extends Skill

func _data():
	name = "力量附能"
	cd = 7
	tab = "萨满"

func getDec():
	return tr("最近%d名友军获得%d层狂怒和急速") % [5,per(15)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	for i in  masCha.getMinRanChas(2,5):
		masCha.castBuff(i,"b_a_kuangNu",per(15))
		masCha.castBuff(i,"b_a_jiSu",per(15))


