extends Eqp

func _data():
	name = "定海神针"
	isOnly = true
	var ds = {
		atk = 3,
		def = 2,
		mdef = 1,
	}
	attRatio(ds)
	lv = 5
	tab = "谜团"
	dec = tr("普通攻击%d%%几率附加%d层破甲，技能伤害会消除目标破甲，每层破甲造成%d%%物理攻击的真实伤害") % [30,5,10]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(info):
	if info.atkType == ATKTYPE.NORMAL && rndPer(0.3):
		masCha.castBuff(info.cha,"b_b_poJia",5)
	elif info.atkType == ATKTYPE.SKILL :
		var buff = info.cha.hasAff("b_b_poJia")
		if buff.lv >= 5 :
			hurt(info.cha,masCha.atk * buff.lv * 0.1,HURTTYPE.REAL,ATKTYPE.EFF)
			buff.del()
