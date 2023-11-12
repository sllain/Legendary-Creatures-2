extends Skill

func _data():
	name = "锋刃追击"
	cd = 0
	tab = "剑士"

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	masCha.connect("onCastSkill",self,"r2")

var n = 0
func r2(skill):
	n += 1

func r(atkInfo):
	if n > 0 && atkInfo.atkType == ATKTYPE.NORMAL :
		atkInfo.val *= per(1.8)
		n -= 1
		masCha.castBuff(atkInfo.cha,"b_b_liuXue",per(15))

func getDec():
	return tr("施放技能时，下次普攻提高%d%%的伤害，附加%d层流血") % [per(2.0) * 100,per(15)]
