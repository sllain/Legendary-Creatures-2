extends GemUn

func _data():
	name = "追击石"
	tab = "战士 刺客"
	isUnique = true
	
	
func _in():
	masCha.connect("onCastHurtStart",self,"r")
	masCha.connect("onCastSkill",self,"r2")

var n = 0
func r2(skill):
	n += 1

func r(atkInfo):
	if n > 0 && atkInfo.atkType == ATKTYPE.NORMAL :
		n -= 1
		hurtPerP(atkInfo.cha,per(0.9),ATKTYPE.EFF)

func getDec():
	return tr("施放技能时，下次普攻附加%d%%的物理伤害") % [per(90)]
