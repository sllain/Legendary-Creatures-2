extends Skill

func _data():
	name = "充电"
	cd = 0
	tab = "机关人"
	
func getDec():
	return tr("施加和被施加麻痹时，基础属性提升%d%%，最高%d%%，战斗结束重置") %  [5,per(140)]

var p = 0

func _in():
	masCha.connect("onCastBuff",self,"_r")
	masCha.connect("onAddBuff",self,"_r")
	p = 0
	upAtt()
	
func _r(buff):
	if buff.id == "b_b_maBi" && p < per(1.4):
		p += 0.05
		upAtt()

func upAtt():
	perAdd("maxHp",p)
	perAdd("atk",p)
	perAdd("matk",p)
	perAdd("def",p)
	perAdd("mdef",p)
