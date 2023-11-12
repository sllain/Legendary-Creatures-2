extends Skill

func _data():
	name = "火焰之力"
	cd = 0
	tab = "专属"

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(0.6):
		castCha.hurt(atkInfo.cha,per(1.0) * castCha.matk,HURTTYPE.MAG,ATKTYPE.EFF)
		masCha.castBuff(atkInfo.cha,"b_b_shaoZhuo",3)
		
func getDec():
	return tr("普攻%d%%的几率造成%d%%魔法伤害附加%d层烧灼，并且获得技能冷却速度一半的攻速") % [60,per(100),per(10)]

func _upS():
	self.spd = masCha.cdSpd * 0.5
