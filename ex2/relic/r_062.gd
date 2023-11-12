extends Relic

func _data():
	name = "鏖战磨练"
	
func getDec():
	return tr("精英战斗额外获得 %d * 战斗等级的魂") % [lvPer(lv,5)]

func _in():
	sys.game.connect("onBattleEnd",self,"r")

func r(isWin):
	if isWin and sys.batScene.faci.id == "faci_bat2":
		sys.player.items.addItem(data.newBase("m_xp").setNum(lvPer(lv,5)*sys.batScene.faci.lv))
	
