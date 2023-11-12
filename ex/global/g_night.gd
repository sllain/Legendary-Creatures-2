extends Global

func _data():
	name = "夜晚"
	txt = "夜晚"
	excMode = "tower"

func setLv(val):
	.setLv(val)
	self.dec = tr("夜晚探索范围减少1格，敌人获得增益状态，同时获取的魂值提高")

func _in():
	lv = 0
	sys.game.connect("onNextTime",self,"r")
	sys.game.connect("onBattleReady",self,"_bat")
	r()

func _bat():
	if sys.game.isNight():
		for i in sys.batScene.getAllChas():
			if i.team != sys.player.team :
				i.castBuff(i,"b_a_diYu",25)
				i.castBuff(i,"b_a_kuangNu",25)
				i.castBuff(i,"b_a_weiNeng",25)
	
func r():
	self.isVisIco = sys.game.isNight()
