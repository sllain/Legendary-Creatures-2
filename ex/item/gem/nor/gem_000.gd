extends Gem
class_name GemAttL

func _data():
	name = "攻击石"
	tab = "战士 刺客 射手"
	icoId = "ico_gem_2"
	pn = 0.08

var aid = "atk"
var pn = 0.1
func setLv(val):
	.setLv(val)
	var a = lvPer(lv,pn)
	perAdd(aid,a)
	dec = tr("+%d%% %s") % [a * 100,tr(cons.attDs[aid].name)]
