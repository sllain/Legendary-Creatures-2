extends Skill

func _data():
	name = "果味十足"
	cd = 5
	tab = "专属"

func getDec():
	return tr("回复周围2格友军%d%%的最大生命值") % per(5)

func _cast():
	masCha.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	for i in masCha.scene.getCellChas(mas.cell,2):
		if i.team == mas.team :
			masCha.plusHp(i.maxHp * per(0.05),i)
