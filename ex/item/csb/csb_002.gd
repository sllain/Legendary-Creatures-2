extends Csb

func _data():
	name = "小血瓶"
	
func _use():
	var xcha = null
	for cha in sys.batScene.getAllChas():
		if cha.team != sys.player.team:continue
		if xcha == null:
			xcha = cha
			continue
		if cha.team == sys.player.team :
			if xcha.hp / xcha.maxHp > cha.hp / cha.maxHp :
				xcha = cha
	if xcha != null	:
		xcha.plusHp(lvPer(lv,600),xcha)

func getDec():
	return tr("回复最虚弱友军%d生命值") % [lvPer(lv,600)]
