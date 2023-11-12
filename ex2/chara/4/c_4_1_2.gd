extends Chara

func _data():
	name = "夜魔"
	tab = "刺客 忍者"
	animFile = "res://res/anim/p_2/Satyr.tres"
	typeRotio(4)
	skillIds = ["k_c_4_1_2"]
	animScale = Vector2(1.4,1.4)
	animOffset = Vector2(10,0)
	lock = 0
	origin = "地牢"
	#lockType = 1
	achDec = "升级一个刺客到5级"

func _ach():
	sys.game.connect("onChaPlusLv",self,"_rach")
func _rach(cha):
	if cha.hasTab("刺客") && cha.team == sys.player.team && cha.lv >= 5 :
		achCom()
