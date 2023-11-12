extends Gem

func _data():
	tab = "战士"
	name = "狂怒石"
	icoId = "ico_gem_2"


func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 拥有狂怒时增伤") % [lvPer(lv,0.10) * 100]

func _in():
	masCha.connect("onCastHurtStart",self,"r1")

func r1(info):
	if masCha.hasAff("b_a_kuangNu") != null:
		info.per += lvPer(lv,0.10)
