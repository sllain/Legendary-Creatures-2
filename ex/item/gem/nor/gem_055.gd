extends Gem

func _data():
	tab = "射手 刺客"
	name = "急速石"
	icoId = "ico_gem_2"


func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 拥有急速时增伤") % [lvPer(lv,0.10) * 100]

func _in():
	masCha.connect("onCastHurtStart",self,"r1")

func r1(info):
	if masCha.hasAff("b_a_jiSu") != null:
		info.per += lvPer(lv,0.10)
