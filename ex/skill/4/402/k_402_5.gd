extends Skill

func _data():
	name = "毒创"
	cd = 0
	tab = "毒枭"

func getDec():
	return tr("普攻附加%d%%的物理伤害，每层中毒使该伤害提高3%%") % [per(90)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		var p = 1.0
		var bf = atkInfo.cha.hasAff("b_b_zhongDu")
		if bf != null :
			p += bf.lv * 0.3
		hurt(atkInfo.cha,masCha.atk * per(0.9) * p,HURTTYPE.PHY,ATKTYPE.EFF)

