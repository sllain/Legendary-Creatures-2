extends Csb

func _data():
	name = "隐身药水"
	
func getDec():
	return tr("使所有友军获得%d层隐身") % [lvPer(lv,5)]

func _use():
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team != sys.player.team:continue
		cha.castBuff(cha,"b_a_yinShen",per(5))

