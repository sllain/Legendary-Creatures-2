extends Skill

func _data():
	name = "能量调配"
	cd = 9
	tab = "炼金术士"

func getDec():
	return tr("使你最大生命值，物理攻击，魔法攻击最高的3名随从分别获得%d层抵御 狂怒和威能，并恢复%d%%魔法攻击的生命值") % [per(10),per(100)]

func _cast():
	mas.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var cha = masCha.getMaxAttCha("maxHp",2)
	if cha != null:
		masCha.plusHp(masCha.matk * per(1.0),cha)
		masCha.castBuff(cha,"b_a_diYu",per(10))

	cha = masCha.getMaxAttCha("atk",2)
	if cha != null:
		masCha.plusHp(masCha.matk * per(1.0),cha)
		masCha.castBuff(cha,"b_a_kuangNu",per(10))
		
	cha = masCha.getMaxAttCha("matk",2)
	if cha != null:
		masCha.plusHp(masCha.matk * per(1.0),cha)
		masCha.castBuff(cha,"b_a_weiNeng",per(10))
