extends GemUn

func _data():
	name = "怒能石"
	tab = "辅助"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("施加护盾时，目标获得%d层狂怒和威能") % [per(7)]

func _in():
	masCha.connect("onCastPlus",self,"r")
	
func r(info):
	if info.type == "ward" :
		masCha.castBuff(info.cha,"b_a_kuangNu",per(7))
		masCha.castBuff(info.cha,"b_a_weiNeng",per(7))
