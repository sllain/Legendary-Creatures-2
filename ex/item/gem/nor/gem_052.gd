extends Gem

func _data():
	tab = "辅助"
	name = "双疗石"
	icoId = "ico_gem_6"

var hurtR = 0.08

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 施加的护盾和治疗效果") % [lvPer(lv,hurtR) * 100]

func _in():
	masCha.connect("onCastPlusStart",self,"r1")

func r1(info):
	info.per += lvPer(lv,hurtR)
