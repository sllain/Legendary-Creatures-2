extends Relic

func _data():
	name = "训练-%s" % cons.attDs[aid].name
	
func _in():
	sys.game.connect("onChaInScene",self,"r")
	
func r(cha):
	var att = Att.new()
	cha.addAtt(att)
	att.perAdd(aid,lvPer(lv,0.08))
			
var aid = "atk"
func setLv(val):
	.setLv(val)
	dec = tr("全队 +%d%% %s") % [lvPer(lv,0.08) * 100,tr(cons.attDs[aid].name)]
