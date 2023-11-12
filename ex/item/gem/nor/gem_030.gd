extends Gem

func _data():
	tab = "射手 刺客"
	name = "普攻石"
	icoId = "ico_gem_2"

var hurtR = 0.13

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 普攻伤害") % [lvPer(lv,hurtR) * 100]

func _in():
	mas.connect("onCastHurtStart",self,"r1")

func r1(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		atkInfo.per += lvPer(lv,hurtR)
