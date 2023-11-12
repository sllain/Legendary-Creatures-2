extends GemUn

func _data():
	name = "冷冽石"
	tab = "法师 刺客"
	isUnique = true

func getDec():
	return tr("普通攻击减少%d%%所有技能冷却") % per(6)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.hurtType == ATKTYPE.NORMAL:
		for i in masCha.skills.items:
			i.cdVal += i.cd * per(0.06)
