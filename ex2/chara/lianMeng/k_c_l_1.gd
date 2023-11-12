extends Skill

func _data():
	name = "蛮族血统"
	cd = 0
	tab = "专属"
func getDec():
	return tr("生命值高于%d%%时 + %d%%的增伤，低于时 + %d%%的减伤") % [50,per(p) * 100,per(p) * 100]

var p = 0.4
func _in():
	masCha.connect("onHurtStart",self,"r")
	masCha.connect("onCastHurtStart",self,"r2")

func r(atkInfo):
	if masCha.hp / masCha.maxHp < 0.5 :
		atkInfo.per -= per(p)

func r2(atkInfo):
	if masCha.hp / masCha.maxHp >= 0.5 :
		atkInfo.per += per(p)
