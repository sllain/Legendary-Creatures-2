extends Gem

func _data():
	tab = "法师"
	name = "威能石"
	icoId = "ico_gem_2"


func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 拥有威能时增伤") % [lvPer(lv,0.10) * 100]

func _in():
	masCha.connect("onCastHurtStart",self,"r1")

func r1(info):
	if masCha.hasAff("b_a_weiNeng") != null:
		info.per += lvPer(lv,0.10)
