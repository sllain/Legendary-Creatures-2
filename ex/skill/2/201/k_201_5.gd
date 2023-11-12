extends Skill

func _data():
	name = "精准破伤"
	cd = 0
	tab = "弓手"
	
func getDec():
	return tr("暴击时，附加%d%%的物理攻击的真实伤害，目标每层破甲伤害提高%d%%") % [per(70),3]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(info):
	if info.isCri == true:
		var p = 1
		for i in info.cha.affs:
			if i.id == "b_b_poJia" :
				p += i.lv * 0.03
		hurtPer(info.cha,per(0.7) * p,HURTTYPE.REAL,ATKTYPE.EFF)
  
