extends Skill

func _data():
	name = "钢铁之躯"
	cd = 0
	tab = "机关人"
	
func getDec():
	return tr("免疫中毒，+%d%%最终物理减伤，所受的治疗效果转为护盾") %  [per(0.4)*100]

func _in():
	masCha.connect("onAddBuff",self,"r1")
	masCha.connect("onPlusStart",self,"r2")
	masCha.connect("onHurtStart",self,"r3")
	
func r1(buff):
	if buff.id == "b_b_zhongDu" :
		buff.del()
		
func r2(info):
	if info.type == "hp" :
		info.type = "ward"
	
func r3(info):
	if info.hurtType == HURTTYPE.PHY :
		 info.finalPer -= per(0.4)
