extends Gem

func _data():
	tab = "战士 射手"
	name = "近伤石"
	icoId = "ico_gem_2"

var hurtR = 0.12

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 伤害对近战单位") % [lvPer(lv,hurtR) * 100]

func _in():
	mas.connect("onCastHurtStart",self,"r1")

func r1(atkInfo):
	if atkInfo.cha.ran <= 1:
		atkInfo.per += lvPer(lv,hurtR)
