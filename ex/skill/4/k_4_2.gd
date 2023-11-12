extends Skill

func _data():
	name = "敛声屏气"
	cd = 0
	tab = "刺客"

func getDec():
	return tr("开战时获得%d层隐身，急速和狂怒") % [per(20)]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	masCha.castBuff(masCha,"b_a_yinShen",per(20))
	masCha.castBuff(masCha,"b_a_jiSu",per(20))
	masCha.castBuff(masCha,"b_a_kuangNu",per(20))
	pass
