extends Chara

func _data():
	name = "冰晶人"
	tab = "法师 冰法"
	animFile = "res://res/anim/p_3/Phantom Knight.tres"
	typeRotio(5)
	skillIds = ["k_c_5_1_2"]
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	animOffset = Vector2(4,0)
	lock = 0
	origin = "地牢"

	#lockType = 1
	achDec = "升级一个法师到5级"

func _ach():
	sys.game.connect("onChaPlusLv",self,"_rach")
func _rach(cha):
	if cha.hasTab("法师") && cha.team == sys.player.team && cha.lv >= 5 :
		achCom()
