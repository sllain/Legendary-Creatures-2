extends Skill

func _data():
	name = "盾击"
	cd = 0
	tab = "专属"

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		plusWard(masCha.maxHp * per(0.05))
		hurt(atkInfo.cha,masCha.ward * per(0.3),HURTTYPE.PHY,ATKTYPE.EFF)

func getDec():
	return tr("普通攻击时获得%d%%最大生命值的护盾，并附加自身%d%%护盾值的物理伤害") % [per(5),per(0.3) * 100]
