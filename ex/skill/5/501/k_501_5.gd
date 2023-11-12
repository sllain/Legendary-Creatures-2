extends Skill

func _data():
	name = "冰霜护甲"
	cd = 6
	tab = "冰法"
	
func getDec():
	return tr("为防御最高的友军附加%d%%法强的护盾，并为其周围敌人附加%d层结霜") % [per(1.8) * 100,per(10)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.3),"timeout")
	var cha = masCha.getMaxAttCha("def",2)
	if cha != null:
		masCha.plusWard(masCha.matk * lvPer(lv,1.8),cha)
		for i in masCha.scene.getCellChas(cha.cell) :
			if i.team != mas.team :
				masCha.castBuff(i,"b_b_jieShuang",per(10))
