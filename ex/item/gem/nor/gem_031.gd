extends Gem

func _data():
	tab = "战士 刺客 法师"
	name = "技伤石"
	icoId = "ico_gem_1"

var hurtR = 0.12

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 技能伤害") % [lvPer(lv,hurtR) * 100]

func _in():
	mas.connect("onCastHurtStart",self,"r1")

func r1(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		atkInfo.per += lvPer(lv,hurtR)
