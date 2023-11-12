extends Gem

func _data():
	tab = "辅助"
	name = "增疗石"
	icoId = "ico_gem_6"

var hurtR = 0.10

func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 施加的治疗效果") % [lvPer(lv,hurtR) * 100]

func _in():
	masCha.connect("onCastPlusStart",self,"r1")

func r1(info):
	if info.type == "hp" :
		info.per += lvPer(lv,hurtR)
