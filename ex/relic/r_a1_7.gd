extends Relic

func _data():
	name = "幻影残像"
	lock = 0
	
func getDec():
	return tr("战斗开始时，战士将复制一个自身，但减少%d%%的增伤和减伤") % [100 - per(20)]

func _in():
	sys.game.connect("onBattleStart",self,"r")

func r():
	for i in sys.batScene.getAllChas():
		if i.team == sys.player.team && i.isSummon == false && i.hasTab("战士") :
			var cha :Chara= i.summCopy(i,null,100-per(20))
			cha.hp = i.hp
			cha.plusHp(0)
			cha.hp = cha.maxHp
