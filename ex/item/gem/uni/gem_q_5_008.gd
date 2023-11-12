extends GemUn

func _data():
	name = "法技石"
	tab = "法师 辅助"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("战斗开始时,技能CD减少%d%%") % [per(20)]

func _in():
	sys.game.connect("onBattleStart",self,"r")
	
func r():
	for i in masCha.skills.items:
		if i.cd != 0 : i.cdVal += per(0.2) * i.cd
