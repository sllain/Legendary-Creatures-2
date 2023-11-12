extends GemUn

func _data():
	name = "御石"
	tab = "坦克"
	isUnique = true
	
var hpv = 0.0

func _in():
	masCha.connect("onHurt",self,"r")
	
func r(atkInfo):
	hpv += atkInfo.val
	if hpv >= masCha.maxHp * 0.15:
		masCha.castBuff(masCha,"b_a_diYu",per(5))
		hpv = 0.0

func getDec():
	return tr("每承受15%%的最大生命值的伤害，获得%d层抵御") % [ per(5)]
