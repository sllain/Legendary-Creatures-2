extends Faci

var type = 0
func _data():
	name = "资源"
	var rn = rand_range(0,99)
	if rn < 45 :
		setType(0)
	elif rn < 90 :
		setType(1)
	else:
		setType(2)
		
	dec = ""
	weight = 1
	num = 60
	tab = "world dungeon"
	dnum = 3
	
func setType(val):
	type = val
	if type == 0 :
		name = "金币"
		icoId = "ico_m_gold"
	elif type == 1 :
		name = "魂"
		icoId = "ico_m_xp"
	else:
		name = "晶石"
		icoId = "ico_m_cry"

func _trig():
	var id = ""
	var mn = 0
	if type == 0 :
		id = "m_gold"		
		mn = 30
	elif type == 1 :
		id = "m_xp"		
		mn = 15
	else:
		id = "m_cry"
		mn = 2
	var itemPck = ItemPck.new()
	var i1 = data.newBase(id)
	i1.num = per(mn)
	itemPck.addItem(i1)

	sys.eventDlg.items(itemPck)
	del()

func getSave():
	var ds = {
		type = type,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("type",ds)
	setType(type)
