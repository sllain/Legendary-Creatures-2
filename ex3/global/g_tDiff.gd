extends Global

func _data():
	name = "难度"
	txt = tr("难度")
	excMode = "map"

func _in():
	lv = sys.game.diffLv
	sys.game.connect("onBattleReady",self,"_bat")

func _bat():
	for i in sys.batScene.getAllChas():
		if i.team != sys.player.team :
			var att = Att.new()
			i.addAtt(att)
			var p = 0.1 * lv - 0.4
			att.perMul("def",p)
			att.perMul("mdef",p)
			att.perMul("atk",p)
			att.perMul("matk",p)
			att.perMul("maxHp",p)	
