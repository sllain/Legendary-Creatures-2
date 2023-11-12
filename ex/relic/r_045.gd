extends Relic

func _data():
	name = "夜盗"
	excMode = "tower"
	
func getDec():
	return tr("夜晚的精英战胜利后，获得额外 %d * 战斗等级 的 金币") %[lvPer(lv,15)]

func _in():
	sys.game.connect("onBattleEnd",self,"r")

func r(isWin):
	if isWin and sys.game.isNight() and sys.batScene.faci.id == "faci_bat2":
		sys.player.items.addItem(data.newBase("m_gold").setNum(sys.batScene.lv*lvPer(lv,15)))
