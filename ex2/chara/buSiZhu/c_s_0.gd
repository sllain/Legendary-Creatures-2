extends Chara

func _data():
	name = "鬼魂"
	tab = "忍者 侠客"
	animFile = "res://res/anim/undead/1.tres"
	typeRotio(1)
	skillIds = ["k_c_s_0"]
	animOffset = Vector2(-4,13)
	origin = "祭坛"
	lock = -1


func getSave():
	var ds = {
		tab = tab,
		sran = attBase.ran
	}
	ds.merge(.getSave())
	return ds

func setSave(ds):
	.setSave(ds)
	dsSet("tab",ds)
	attBase.ran = ds.sran
	setLv(lv)
