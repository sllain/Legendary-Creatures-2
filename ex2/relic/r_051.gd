extends Relic

func _data():
	name = "利息"
	lock = 0
	excMode = "tower"
	
func getDec():
	return tr("游戏中每过1天，获得当前金币的%d%%") % [lvPer(lv,3)]

func _in():
	sys.game.connect("onNextDay",self,"r")

func r():
	var d = sys.player.items.hasIdItem("m_gold").num * per(0.03)
	sys.player.items.addItem(data.newBase("m_gold").setNum(d))
