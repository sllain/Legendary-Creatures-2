extends GemUn

func _data():
	name = "海妖石"
	tab = "射手"
	isUnique = true

func _in():
	masCha.connect("onNormAtk",self,"r")
	masCha.connect("onCastHurtStart",self,"r2")

func r2(atkInfo):
	if n >= 3 && atkInfo.atkType == ATKTYPE.NORMAL :
		hurt(atkInfo.cha,masCha.atk * per(0.5),HURTTYPE.REAL,ATKTYPE.EFF)
		n = 0
		
var n = 0
func r():
	n += 1

func getDec():
	return tr("每3次普通攻击附加%d%%物理攻击的真实伤害") % per(50)
