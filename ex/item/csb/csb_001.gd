extends Csb

func _data():
	name = "血瓶"
	
func _use():
	for cha in sys.batScene.getAllChas():
		if cha.team != sys.player.team:continue
		cha.plusHp(lvPer(lv,300),cha)

func getDec():
	return tr("回复全队%d点生命值") % [lvPer(lv,300)]
	
