extends Csb

func _data():
	name = "护盾卷轴"
	lock = 0

func getDec():
	return tr("为我方所有友军施加%d的护盾") % lvPer(lv,250)

func _use():
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team != sys.player.team:continue
		cha.plusWard(lvPer(lv,250),cha)

