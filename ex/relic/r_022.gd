extends Relic

func _data():
	name = "训练-防御"
	
func _in():
	sys.game.connect("onChaInScene",self,"r")
	
func r(cha):
	if cha.team != sys.player.team :return
	var att = Att.new()
	cha.addAtt(att)
	att.perAdd("def",lvPer(lv,0.08))
	att.perAdd("mdef",lvPer(lv,0.08))
			
func setLv(val):
	.setLv(val)
	dec = tr("全队 +%d%% 双抗") % [lvPer(lv,0.08) * 100]
