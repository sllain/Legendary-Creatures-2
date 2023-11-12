extends Gem

func _data():
	tab = "坦克"
	name = "技防石"
	icoId = "ico_gem_3"

var hurtR = 0.13

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 减伤对技能") % [lvPer(lv,hurtR) * 100]

func _in():
	mas.connect("onHurtStart",self,"r1")

func r1(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		atkInfo.per -= lvPer(lv,hurtR)
