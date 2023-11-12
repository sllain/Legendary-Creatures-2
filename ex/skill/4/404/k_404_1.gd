extends Skill

func _data():
	name = "蓄势待发"
	cd = 0
	tab = "暗杀者"
	
func getDec():
	return tr("隐身期间每秒回复%d%%已损失生命值") % [per(0.12)*100]

var times = 0

func _upS():
	if masCha.yingTime > 0:
		masCha.plusHp((masCha.maxHp-masCha.hp)*per(0.12))
