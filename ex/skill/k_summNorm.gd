extends Skill
func _data():
	lock = -1

func _in():
	masCha.connect("onHurt",self,"r")

func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && atkInfo.castCha.ran == 1:
		atkInfo.cha.aiCha = masCha
