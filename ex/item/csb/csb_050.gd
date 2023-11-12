extends Csb

func _data():
	name = "主仆契约"
	lock = -1
	tab = "黑店"
	
func getDec():
	return tr("战斗胜利后，%d%%概率随机获取当前敌方一名非boss单位") %[setRate()*100]

func _use():
	var bf = sys.game.player.addAff(data.newBase("b_a_zhuPuQiYue"))
	bf.rate = setRate()
	
func setRate():
	return 0.3 + 0.1*lv
