extends PubBuff

func _data():
	name = "中毒"
	isDie = true
	isLong = false

	tab = "deBuff"
	effId = "e_buffZhongDu"

func _in():
		masCha.connect("onHurt",self,"r")
		
func r(atkInfo):
	if atkInfo.atkType != ATKTYPE.EFF :
		castCha.hurt(masCha,atkInfo.finalVal * per(0.3),atkInfo.hurtType,ATKTYPE.EFF,self)

func getDec():
	return tr("额外承受 %d%%的伤害，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
