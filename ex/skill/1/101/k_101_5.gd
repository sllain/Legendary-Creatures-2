extends Skill

func _data():
	name = "伤口撕裂"
	tab = "剑士"
	cd = 0

func getDec():
	return tr("对敌人附加的流血达到%d层时，消除层数，造成%d%%的最大生命值的真实伤害") % [30,per(30)]


func _in():
	masCha.connect("onCastBuff",self,"r")

func r(buff:Buff):
	if buff.id == "b_b_liuXue" && buff.lv >= 30:
		hurt(buff.masCha,per(0.30) * buff.masCha.maxHp,HURTTYPE.REAL,ATKTYPE.EFF)
		buff.lv -= 30

