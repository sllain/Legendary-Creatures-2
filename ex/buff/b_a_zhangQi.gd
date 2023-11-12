extends Buff

func _data():
	name = "瘴气"
	isDie = false
	isLong = true
	maxLv = 50
	tab = "buff"
	lock = -1
	isVis = false
	
var mp = 1.0

func setLv(val):
	.setLv(val)
	perAdd("maxHp",lv * 0.01 * mp)
	perAdd("atk",lv * 0.01 * mp)
	perAdd("matk",lv * 0.01 * mp)
	perAdd("def",lv * 0.01 * mp)
	perAdd("mdef",lv * 0.01 * mp)
	
func getDec():
	return tr("生命值 攻击 防御 各 提高 %d%%") % [1 * lv * mp]

