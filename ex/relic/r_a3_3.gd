extends Relic

func _data():
	name = "安全可靠"
	
func getDec():
	return tr("开战时，坦克为周围1格友方附加%d%%他最大生命值的护盾") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onBattleStart",self,"r")

func r():
	for i in sys.batScene.getAllChas():
		if i.team == sys.player.team && i.hasTab("坦克") :
			for j in sys.batScene.getCellChas(i.cell):
				if j.team == i.team :
					i.plusWard(i.maxHp * lvPer(lv,0.1),j)
