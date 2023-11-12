extends Relic

func _data():
	name = "超速施法"
	
func getDec():
	return tr("开战时法师，所有技能cd减少%d秒") % [lvPer(lv,3)]

func _in():
	sys.game.connect("onBattleStart",self,"r")

func r():
	for i in sys.batScene.getAllChas():
		if i.team == sys.player.team && i.hasTab("法师") :
			for j in i.skills.items:
				if j.cd != 0 : j.cdVal += lvPer(lv,3)
