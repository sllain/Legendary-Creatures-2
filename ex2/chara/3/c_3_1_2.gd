extends Chara

func _data():
	name = "兵长"
	tab = "坦克 盾卫"
	animFile = "res://res/anim/p/p7.tres"
	typeRotio(3)
	skillIds = ["k_c_3_1_2"]
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	origin = "城镇"
	lock = 0

	#lockType = 1
	achDec = "升级一个坦克到5级"

func _ach():
	sys.game.connect("onChaPlusLv",self,"_rach")
func _rach(cha):
	if cha.hasTab("坦克") && cha.team == sys.player.team && cha.lv >= 5 :
		achCom()
