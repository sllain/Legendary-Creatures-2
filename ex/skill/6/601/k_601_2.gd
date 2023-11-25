extends Skill

func _data():
	name = "群体治疗"
	cd = 9
	tab = "牧师"

func getDec():
	return tr("最虚弱3个友军回复%d%%魔法攻击的生命值和%d层抵御") % [per(100),per(10)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var chas = []
	for i in scene.getAllChas():
		if i.team == masCha.team && i.isSummon == false:
			chas.append(i)
	chas.sort_custom(self,"sort")
	for i in 3 :
		if i >= chas.size() : break
		var cha = chas[i]
		plusHp(masCha.matk * per(1.0),cha)
		masCha.castBuff(cha,"b_a_diYu",per(10))

func sort(a,b):
	if a.hp/a.maxHp < b.hp/b.maxHp :
		return true
	return false
	
