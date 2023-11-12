extends Skill

func _data():
	name = "回音击"
	cd = 0
	tab = "飞刺兽"

func getDec():
	return tr("普攻附加%d%%目标最大生命值的物理伤害，目标每层负面状态使这个伤害提升%d%%") % [per(5),3]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		var n = 1
		for i in atkInfo.cha.affs:
			if i.hasTab("deBuff") :
				n += i.lv
		hurt(atkInfo.cha,atkInfo.cha.maxHp * per(0.05) * lvPer(n,1,0.03),HURTTYPE.PHY,ATKTYPE.EFF)
