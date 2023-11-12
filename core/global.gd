extends Obj
class_name Global
#整局游戏挂载事件

signal onSetIsVisIco()
signal onSetTxt()

var isVisIco = false setget setIsVisIco
func setIsVisIco(val):
	isVisIco = val
	emit_signal("onSetIsVisIco")

var txt = "" setget setTxt
func setTxt(val):
	txt = val
	emit_signal("onSetTxt")

func loadInfo(id):
	self.id = id
	icoId = "ico_%s" % id
	_data()
	self.lv = lv
	_dataEnd()

func getSave():
	var ds = {
		isVisIco = isVisIco,
		txt = txt,
		dec = dec,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("isVisIco",ds)
	dsSet("txt",ds)
	dsSet("dec",ds)

func _pressed():
	pass
