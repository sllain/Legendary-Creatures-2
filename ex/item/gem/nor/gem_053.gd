extends Gem

func _data():
	tab = "战士 法师"
	name = "超然石"
	icoId = "ico_gem_2"


func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 拥有超然时增伤") % [lvPer(lv,0.10) * 100]

func _in():
	masCha.connect("onCastHurtStart",self,"r1")

func r1(info):
	if masCha.hasAff("b_a_chaoRan") != null:
		info.per += lvPer(lv,0.10)
