extends Skill

func _data():
	name = "陷阱守卫"
	cd = 0
	tab = "专属"

func getDec():
	return tr("无法移动，但获得 %d射程，%d%%减伤，%d%%攻速") % [5,40,per(40)]

func _in():
	masCha.connect("onHurt",self,"r")
	masCha.canMove = false
	
func r(atkInfo):
	atkInfo.per -= 0.4
	
func setLv(val):
	.setLv(val)
	self.ran = 5
	self.spd = per(0.4)
