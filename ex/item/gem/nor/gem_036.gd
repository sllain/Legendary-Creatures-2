extends Gem

func _data():
	tab = "战士 刺客 射手"
	name = "物伤石"
	icoId = "ico_gem_1"

var hurtR = 0.12

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 物理伤害") % [lvPer(lv,hurtR) * 100]

func _in():
	mas.connect("onCastHurtStart",self,"r1")

func r1(atkInfo):
	if atkInfo.hurtType == HURTTYPE.PHY:
		atkInfo.per += lvPer(lv,hurtR)
