extends Skill

func _data():
	name = "金钟罩"
	cd = 0
	tab = "格斗家"

func _in():
	masCha.connect("onCastSkill",self,"r2")

func r2(skill):
	var p = 1
	for i in masCha.affs:
		if i is Buff && i.hasTab("buff") && i.lv > 0:
			p += (i.lv / 5 ) * 0.15
			
	masCha.plusWard(masCha.atk * per(1.0) * p)
	
func getDec():
	return tr("施放技能时，获得%d%%物理攻击的护盾，身上每5层增益状态，使该值提高%d%%") % [per(1.0) * 100,15]
