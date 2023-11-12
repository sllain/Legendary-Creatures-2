extends Relic

func _data():
	name = "食物补给"
	lock = 0
	excMode = "tower"
	
func getDec():
	return tr("大地图移动时，回复队伍%d%%已损失生命值") % [lvPer(lv,6)]

func _in():
	sys.game.connect("onPlayerMove",self,"r")

func r():
	var chas = sys.player.team.chas
	for i in chas:
		i.plusHp(lvPer(lv,0.6)*(i.maxHp-i.hp))
