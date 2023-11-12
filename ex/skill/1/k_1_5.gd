extends Skill

func _data():
	name = "勇往无前"
	tab = "战士"
	cd = 7

func getDec():
	return tr("获得%d%%物理攻击的护盾，每损失10%%的生命值，提高10%%的护盾值") % per(150)

func _cast():
	masCha.plusWard(masCha.atk * per(1.5) * ( 1 +  masCha.hp / masCha.maxHp) )

