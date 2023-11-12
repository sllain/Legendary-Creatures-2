extends Relic

func _data():
	name = "瞄准弱点"
	
func getDec():
	return tr("射手的暴击伤害提高%d%%") % [lvPer(lv,15)]

func _in():
	sys.game.connect("onChaInScene",self,"r")
	
func r(cha):
	if cha.hasTab("射手") == false:return
	var att = Att.new()
	cha.addAtt(att)
	att.perAdd(aid,lvPer(lv,0.15))
			
var aid = "criR"
