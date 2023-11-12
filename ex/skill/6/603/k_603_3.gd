extends Skill

func _data():
	name = "庇佑"
	cd = 0
	tab = "圣骑士"
	
func getDec():
	return tr("周围1格友军受到伤害时，减少%d%%的伤害，并代替其承受") %  [per(0.3)*100]

func _in():
	sys.game.connect("onChaHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.cha.team != masCha.team:return
	if atkInfo.cha == atkInfo.castCha:return
	if masCha.distanceTo(atkInfo.cha) != 1 : return
	atkInfo.per -= per(0.3)
	atkInfo.cha = masCha
