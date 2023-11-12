extends PubBuff

func _data():
	name = "眩晕"
	isDie = true
	isLong = false
	dec = "无法行动"
	tab = "deBuff"
	effId = "e_buffXuanYun"

func setLv(val):
	.setLv(val)
	if masCha == null :return
	masCha.yunTime = val * bfsStup
	masCha.playAnim("idle")

func del():
	.del()
	masCha.yunTime = 0
