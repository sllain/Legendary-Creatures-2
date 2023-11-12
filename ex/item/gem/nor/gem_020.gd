extends Gem
class_name GemBuffHurtL

func _data():
	name = "结霜石"
	tab = "法师"
	icoId = "ico_gem_5"

var aid = "b_b_jieShuang"
var hurtR = 0.15

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 伤害对%s单位") % [lvPer(lv,hurtR) * 100,tr(data.newBase(aid).name)]

func _in():
	mas.connect("onCastHurtStart",self,"r1")

func r1(atkInfo):
	if atkInfo.cha.hasAff(aid) != null:
		atkInfo.per += lvPer(lv,hurtR)
