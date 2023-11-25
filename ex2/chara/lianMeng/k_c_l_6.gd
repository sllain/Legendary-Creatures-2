extends Skill

func _data():
	name = "立誓之枪"
	cd = 0
	tab = "专属"
func getDec():
	return tr("普攻时使周围1格友军获得帕拉丁%d%%最大生命值的护盾") %  [per(0.05) * 100]

func _in():
	masCha.connect("onCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		var chas = sys.batScene.getCellChas(masCha.cell,1)
		for i in chas:
			if i == null : continue
			if i.team != masCha.team :continue
			plusWard(masCha.maxHp*per(0.05),i)
			
