extends Chara

func _data():
	name = "人参果"
	tab = "辅助 牧师"
	animFile = "res://res/anim/p_2/Mandrake.tres"
	typeRotio(3)
	ran = 2
	skillIds = ["k_c_6_1_2"]
	animOffset = Vector2(5,0)
	animScale = Vector2(1.6,1.6)
	origin = "地牢"
	lock = 0

	#lockType = 1
	achDec = "升级一个辅助到5级"

func _ach():
	sys.game.connect("onChaPlusLv",self,"_rach")
func _rach(cha):
	if cha.hasTab("辅助") && cha.team == sys.player.team && cha.lv >= 5 :
		achCom()
