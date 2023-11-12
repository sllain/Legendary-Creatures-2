extends Csb

func _data():
	name = "净化药水"
	
func getDec():
	return tr("清除所有友军的负面状态，并恢复%d点生命值") % [lvPer(lv,100)]

func _use():
	for cha in sys.batScene.getAllChas():
		if cha == null:continue
		if cha.team != sys.player.team:continue
		for bf in cha.affs :
				if bf.hasTab("deBuff") :
					bf.del()
		cha.plusHp(lvPer(lv,100),cha)

