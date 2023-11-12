extends Obj
class_name Team
signal onAddCha(cha)
signal onDelCha(cha)

var chas:Array = []

func _in():
	pass

func addCha(cha):
	cha.team = self
	chas.append(cha)
	emit_signal("onAddCha",cha)

func delCha(cha):
	chas.erase(cha)
	emit_signal("onDelCha",cha)

func getSave():
	var chaL = []
	for i in chas:
		chaL.append(i.getSave())
	var ds = {
		chas = chaL
	}
	ds.merge(.getSave())
	return ds

func setSave(ds):
	.setSave(ds)
	for i in ds.chas:
		var cha = data.newBase(i.id)
		cha.setSave(i)
		addCha(cha)
	return self
