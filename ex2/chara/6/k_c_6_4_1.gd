extends Skill

func _data():
	name = "制药"
	cd = 0
	tab = "专属"
	
func getDec():
	return tr("每场战斗结束%d%%的几率获得一瓶随机的%d级药剂") %  [20,lv]

func _in():
	sys.game.connect("onBattleEnd",self,"r")
	
const csbs = ["csb_001","csb_002","csb_003","csb_010","csb_011","csb_012","csb_013"]
	
func r(v):
	if rndPer(0.20) :
		var item = data.newBase(rndListItem(csbs))
		item.lv = lv
		sys.player.items.addItem(item)
