extends GemUn

func _data():
	name = "巨杀石"
	tab = "射手"
	isUnique = true

func _in():
	masCha.connect("onCastHurtStart",self,"r")

func r(atkInfo):
	atkInfo.per += clamp(atkInfo.cha.hp,0.1,999999) / clamp(masCha.hp,0.1,999999) * per(0.15)

func getDec():
	return tr("对手生命值每高你一倍获得%d%%的增伤") % per(15)
