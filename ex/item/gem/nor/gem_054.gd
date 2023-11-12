extends Gem

func _data():
	tab = "坦克 辅助"
	name = "抵御石"
	icoId = "ico_gem_2"


func setLv(val):
	.setLv(val)
	dec = tr("+%d%% 拥有抵御时减伤") % [lvPer(lv,0.10) * 100]

func _in():
	masCha.connect("onHurtStart",self,"r1")

func r1(info):
	if masCha.hasAff("b_a_diYu") != null:
		info.per -= lvPer(lv,0.10)
