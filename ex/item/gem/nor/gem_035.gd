extends Gem

func _data():
	tab = "法师"
	name = "魔伤石"
	icoId = "ico_gem_5"

var hurtR = 0.12

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 魔法伤害") % [lvPer(lv,hurtR) * 100]

func _in():
	mas.connect("onCastHurtStart",self,"r1")

func r1(atkInfo):
	if atkInfo.hurtType == HURTTYPE.MAG:
		atkInfo.per += lvPer(lv,hurtR)
