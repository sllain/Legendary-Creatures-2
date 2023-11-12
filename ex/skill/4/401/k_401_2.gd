extends Skill

func _data():
	name = "忍者之道"
	cd = 0
	tab = "忍者"
	cri = 0.15

func getDec():
	return tr("获得%d%%的暴击率，且每10%%的暴击率使你有%d%%的概率闪避非真实伤害") % [per(15),per(5)]
var val = 0.0
func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.hurtType != HURTTYPE.REAL && rndPer(masCha.cri * per(0.5)):
		atkInfo.val = 0

func setLv(val):
	.setLv(val)
	self.cri = per(0.15)
