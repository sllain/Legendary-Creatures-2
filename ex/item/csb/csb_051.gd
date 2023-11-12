extends Csb

func _data():
	name = "怪盗手套"
	lock = -1
	tab = "黑店"

func getDec():
	return tr("战斗胜利后，%d%%概率随机获取当前敌方的一件装备") %[setRate()*100]

func _use():
	var bf = sys.game.player.addAff(data.newBase("b_a_guaiDaoShouTao"))
	bf.rate = setRate()

func setRate():
	return 0.3 + 0.1*lv
