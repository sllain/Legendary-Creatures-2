extends Skill

func _data():
	name = "化骨掌"
	cd = 0
	tab = "格斗家"

func getDec():
	return tr("普攻附加%d%%目标最大生命值的物理伤害，身上每5层增益状态，使该伤害提高%d%%") % [per(8),15]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		var p = 1
		for i in masCha.affs:
			if i is Buff && i.hasTab("buff") && i.lv > 0:
				p += (i.lv / 5 ) * 0.15
		hurt(atkInfo.cha,atkInfo.cha.maxHp * per(0.08) * p,HURTTYPE.PHY,ATKTYPE.EFF)
