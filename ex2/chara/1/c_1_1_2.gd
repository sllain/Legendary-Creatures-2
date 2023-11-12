extends Chara

func _data():
	name = "巨剑士"
	tab = "战士 剑士"
	animFile = "res://res/anim/p_3/Executioner.tres"
	typeRotio(1)
	skillIds = ["k_c_1_1_2"]
	animOffset = Vector2(10,0)
	#animScale = Vector2(0.5,0.5)
	#animFlip = true
	lock = 0
	origin = "城镇"
	achDec = "升级一个战士到5级"

func _ach():
	sys.game.connect("onChaPlusLv",self,"_rach")
func _rach(cha):
	if cha.hasTab("战士") && cha.team == sys.player.team && cha.lv >= 5 :
		achCom()
		
