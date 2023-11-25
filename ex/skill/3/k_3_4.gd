extends Skill

func _data():
	name = "健硕身躯"
	cd = 10
	tab = "坦克"
	
func getDec():
	return tr("治疗自身%d%%的生命值,受到技能伤害时，减少10%%冷却") %  [per(13)]

func _cast():
	masCha.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	plusHp(masCha.maxHp * per(0.13))

func _in():
	masCha.connect("onHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		cdVal += cd * 0.1

