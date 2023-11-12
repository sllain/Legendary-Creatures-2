extends Skill

var dmg = 0

func _data():
	name = "庞大身躯"
	cd = 0
	tab = "肉霸"
	
func getDec():
	return tr("最终的最大生命值提升%d%%") %  [per(0.3)*100]

func setLv(val):
	.setLv(val)
	perAdd("maxHp",per(0.3))
