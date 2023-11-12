extends PubBuff

func _data():
	name = "烧灼"
	isDie = true
	isLong = false

	tab = "deBuff"
	effId = "e_buffShaoZhuo"

func _upS():
	castCha.hurt(masCha,masCha.maxHp * per(0.05),HURTTYPE.MAG,ATKTYPE.EFF,self)

func getDec():
	return tr("每秒受到%d%%最大生命值的魔法伤害，最高 %d%%") % [per(0.05) * 100,lvPer(maxLv,0.05) * 100]
