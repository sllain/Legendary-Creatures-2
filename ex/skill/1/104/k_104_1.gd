extends Skill

func _data():
	name = "铁布衫"
	cd = 0
	tab = "格斗家"

func getDec():
	return tr("每承受15%%最大生命值的伤害,获得 %d层 狂怒，抵御，急速，超然") % per(12)

var bval = 0
func _in():
	bval = 0
	masCha.connect("onHurt",self,"r")
	
func r(atkInfo):
	bval += atkInfo.finalVal 
	if bval >= masCha.maxHp * 0.15:
		bval = 0
		var n = 12
		masCha.castBuff(masCha,"b_a_kuangNu",per(n))
		masCha.castBuff(masCha,"b_a_diYu",per(n))
		masCha.castBuff(masCha,"b_a_jiSu",per(n))
		masCha.castBuff(masCha,"b_a_chaoRan",per(n))
