extends Csb

func _data():
	name = "冰霜之书"

func getDec():
	return tr("在我方最后排单位周围召唤2个%d级冰霜精灵") % lv

func _use():
	var tCha = null
	for cha in sys.batScene.getAllChas():
		if cha.team != sys.player.team:continue
		if tCha == null:
			tCha = cha
			continue
		if tCha.cell > cha.cell :
			tCha = cha
	if tCha != null:
		for i in 2:
			var cha:Chara= tCha.summ("c_zy_bing")
			cha.lv = lv
