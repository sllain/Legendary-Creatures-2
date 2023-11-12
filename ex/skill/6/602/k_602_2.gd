extends Skill

func _data():
	name = "超然净化"
	cd = 6
	tab = "萨满"

func getDec():
	return tr("最近5个友军获得%d层超然,并净化其负面buff") % [per(10)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var n = 0
	for i in scene.getAllChas():
		if i.team == masCha.team :
			masCha.castBuff(i,"b_a_chaoRan",per(10))
			for j in masCha.affs :
				if j.hasTab("deBuff") :
					j.del()
			n +=1 
			if n >= 5 :break


