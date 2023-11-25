extends Relic

func _data():
	name = "奥术大师"
	
func _in():
	sys.game.connect("onChaInScene",self,"r")
	
func r(cha):
	if cha.team != sys.player.team :return
	if cha.hasTab("法师") == false:return
	var att = Att.new()
	cha.addAtt(att)
	att.perAdd(aid,lvPer(lv,0.09))
			
var aid = "matk"
func setLv(val):
	.setLv(val)
	dec = tr("法师 +%d%% %s") % [lvPer(lv,0.09) * 100,tr(cons.attDs[aid].name)]
