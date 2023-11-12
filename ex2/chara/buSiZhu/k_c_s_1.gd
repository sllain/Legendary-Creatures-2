extends Skill

func _data():
	name = "武士剑道"
	cd = 0
	cri = 0.1
	tab = "专属"
func getDec():
	return tr("技能可以暴击，获得%d%%的暴击率") % [per(30)]

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL :
		atkInfo.canCri = true
		

func setLv(val):
	.setLv(val)
	self.cri = per(0.30)
 
