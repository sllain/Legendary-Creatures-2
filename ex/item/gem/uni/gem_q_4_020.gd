extends GemUn

func _data():
	name = "复活石"
	tab = "射手 法师"
	isUnique = true
	lock = -1
	
func _in():
	sys.game.connect("onBattleStart",self,"r")
	masCha.connect("onDeathStart",self,"rD")
	
func r():
	b = true
	
var b = false
func rD(atkInfo):
	if b && masCha.isDeath:
		masCha.revive(false)
		masCha.castBuff(masCha,"b_a_yinShen",per(5))
		masCha.plusHp(per(800))
		b = false
