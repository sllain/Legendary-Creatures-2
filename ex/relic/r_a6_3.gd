extends Relic

func _data():
	name = "精神导师"
	
func getDec():
	return tr("开战时，辅助为周围1格友方附加%d层，超然和急速") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onBattleStart",self,"r")

func r():
	for i in sys.batScene.getAllChas():
		if i.team == sys.player.team && i.hasTab("辅助") :
			for j in sys.batScene.getCellChas(i.cell):
				if j.team == i.team :
					var b = i.castBuff(j,"b_a_chaoRan",lvPer(lv,10))
					i.castBuff(j,"b_a_jiSu",lvPer(lv,10))
