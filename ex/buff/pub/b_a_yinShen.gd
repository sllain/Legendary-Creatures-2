extends PubBuff

func _data():
	name = "隐身"
	isDie = true
	isLong = false
	dec = "无法被锁定和普攻"
	tab = "buff"

func setLv(val):
	.setLv(val)
	if masCha == null :return
	masCha.yingTime = val * bfsStup

func del():
	.del()
	masCha.yingTime = 0
