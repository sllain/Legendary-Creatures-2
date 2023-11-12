extends Relic

func _data():
	name = "战前准备"
	
func getDec():
	return tr("战斗开始时坦克周围1格友军获得他%d%%的护甲，而他获得双倍的此加成") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onBattleStart",self,"r")

func r():
	for i in sys.batScene.getAllChas():
		if i.team == sys.player.team and i.hasTab("坦克") :
			for j in sys.batScene.getCellChas(i.cell):
				if j.team == i.team:
					var bf = data.newBase("b_a_jianRuPanShi")
					j.addAff(bf)
					if j != i:
						bf.allySetDef(i.def*lvPer(lv,0.1))
					else:
						bf.allySetDef(i.def*lvPer(lv,0.1)*2.0)
