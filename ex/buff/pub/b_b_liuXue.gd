extends PubBuff

func _data():
	name = "流血"
	isDie = true
	isLong = false

	tab = "deBuff"
	effId = "e_buffLiuXue"

func _upS():
	castCha.hurt(masCha,masCha.maxHp * per(0.05),HURTTYPE.PHY,ATKTYPE.EFF,self)

func _in():
	masCha.connect("onPlusStart",self,"r")
	
func r(info):
	if info.type == "hp" :
		info.per -= 0.3

func getDec():
	return tr("治疗效果减少 %d%%，每秒受到%d%%最大生命值的物理伤害，最高 %d%%") % [30,per(0.05) * 100,lvPer(maxLv,0.05) * 100]
