extends Skill

func _data():
	name = "以一抵十"
	cd = 0
	tab = "战士"

func getDec():
	return tr("周围1格每有一个敌人，增伤和减伤 提升%d%%") % [per(25)]

var p = 0

func _in():
	masCha.connect("onHurtStart",self,"r")
	masCha.connect("onCastHurtStart",self,"r2")
	
func r(atkInfo):
	if atkInfo.castCha.lv > masCha.lv:
		atkInfo.per -= p

func r2(atkInfo):
	if atkInfo.cha.lv > masCha.lv:
		atkInfo.per += p

func _upS():
	p = 0
	for i in masCha.scene.getCellChas(mas.cell):
		if i.team != mas.team :
			p += per(0.25)
