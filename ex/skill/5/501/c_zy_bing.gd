extends Chara

func _data():
	name = "冰霜精灵"
	tab = ""
	animFile = "res://res/anim/p_1/Water Wisp.tres"
	ran = 3
	var ds = {
		atk = 9,
		def = 3,
		matk = 7,
		mdef = 3,
		maxHp = 5,
	}
	attRatio(ds)
	lock = -1

func _in():
	connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		castBuff(atkInfo.cha,"b_b_jieShuang",3)
