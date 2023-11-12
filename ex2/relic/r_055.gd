extends Relic

var step = 0

func _data():
	name = "行军练习"
	excMode = "tower"
	
func getDec():
	return tr("每在大地图移动5格，获得%d点魂") % [lvPer(lv,6)]

func _in():
	sys.game.connect("onPlayerMove",self,"r")

func r():
	if sys.game.isMainMap() == false: return
	step += 1
	if step >= 5:
		step = 0
		sys.player.items.addItem(data.newBase("m_xp").setNum(lvPer(lv,6)))
