extends Faci

func _data():
	name = "灯塔"
	dec = "可随机传送至一个未被发现的设施旁"
	weight = 0.5
	tab = "world"
	isCs = true
	num = 5
	
var bl = false

func _in():
	lv = 0
	
func _trig():
	if bl == false:
		var ls = [
				tr("激活：传送至另一个随机设施旁"),
				tr("离开")
			]
		var cry = lvPer(lv,10)
		var inx = yield(sys.eventDlg.selBB(ls),"onSel")
		if inx == 0 :
			var arrs = []
			for i in sys.mapScene.objs.items: 
				if i.visible == false:
					arrs.append(i)
			invalid = true
			if arrs.size() <= 0 :
				sys.eventDlg.txt(tr("没有未激活的设施"))
				bl = true
				return
			var f = sys.rndListItem(arrs)
			sys.mapScene.playFaci.matMoveUp(f.cell)
			bl = true
		else:
			pass
	else:
		var ls = [
				tr("已激活，离开")
			]
		sys.eventDlg.selBB(ls)
	
func getSave():
	var ds = {
		bl = bl,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("bl",ds)
