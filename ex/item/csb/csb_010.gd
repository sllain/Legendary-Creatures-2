extends Csb

func _data():
	var bf = data.newBase(bid)
	name = "祝福水-%s" % bf.name
	bname = bf.name

var bid = "b_a_diYu"
var bname = ""

func _use():
	for cha in sys.batScene.getAllChas():
		if cha.team != sys.player.team:continue
		cha.castBuff(cha,bid,lvPer(lv,20))
		cha.plusHp(lvPer(lv,150),cha)

func getDec():
	return tr("回复全队%d点生命值,并获得%d层 %s") % [lvPer(lv,150),lvPer(lv,20),tr(bname)]
