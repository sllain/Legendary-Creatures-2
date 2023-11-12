extends Skill

func _data():
	name = "血牙"
	cd = 0
	tab = "飞刺兽"

var atkp = 0.5

func getDec():
	return tr("普攻%d%%几率附加%d层流血并造成%d%%的物理伤害，每层流血使该伤害提高%d%%") % [per(30),5,per(atkp) * 100,3]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(lvPer(lv,0.30)) :
		masCha.castBuff(atkInfo.cha,"b_b_liuXue",5)
		var p = 1.0
		var bf = atkInfo.cha.hasAff("b_b_liuXue")
		if bf != null :
			p += bf.lv * 0.3
		hurtPerP(atkInfo.cha,per(atkp) * p,ATKTYPE.EFF)
