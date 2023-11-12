extends Chara

func _data():
	name = "长弓手"
	tab = "射手 弓手"
	animFile = "res://res/anim/p/p20.tres"
	typeRotio(2)
	skillIds = ["k_c_2_1_2"]
	animScale = Vector2(1.2,1.2)
	lock = 0
	origin = "城镇"

	#lockType = 1
	achDec = "升级一个射手到5级"

func _ach():
	sys.game.connect("onChaPlusLv",self,"_rach")
func _rach(cha):
	if cha.hasTab("射手") && cha.team == sys.player.team && cha.lv >= 5 :
		achCom()
