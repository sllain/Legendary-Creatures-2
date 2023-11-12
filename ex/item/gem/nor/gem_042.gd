extends Gem

func _data():
	tab = "坦克"
	name = "近防石"
	icoId = "ico_gem_3"

var hurtR = 0.15

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 减伤对近战") % [lvPer(lv,hurtR) * 100]

func _in():
	mas.connect("onHurtStart",self,"r1")

func r1(atkInfo):
	if atkInfo.castCha.ran < 2:
		atkInfo.per -= lvPer(lv,hurtR)
