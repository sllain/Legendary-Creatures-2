extends GemUn

func _data():
	name = "会心石"
	tab = "射手 刺客"
	isUnique = true
	lock = 0

func getDec():
	return tr("普通攻击20%%概率造成目标%d%%最大生命值的真实伤害") % per(6)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL and sys.rndPer(0.2):
		hurt(atkInfo.cha,atkInfo.cha.maxHp * per(0.06),HURTTYPE.REAL,ATKTYPE.EFF)

