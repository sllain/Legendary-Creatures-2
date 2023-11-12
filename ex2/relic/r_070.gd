extends Relic

var numRe = 0

func _data():
	name = "战略储备"
	
func getDec():
	return tr("战斗中消耗品使用次数上限+%d") % [lvPer(lv,1)]

func _in():
	sys.game.connect("onBattleReady",self,"r")
	sys.game.connect("onBattleEnd",self,"reset")
	
func reset(isWin):
	sys.player.csbNum = numRe
	
func r():
	numRe = sys.player.csbNum
	sys.player.csbNum += lvPer(lv,1)
	var node = sys.batScene.get_parent()
	if node.name == "batDlg":
		node.get_node("%labCsb").text = "%d/%d" % [node.csbNumVal,sys.player.csbNum]
		#"%labCsb".text = "%d/%d" % [csbNumVal,sys.player.csbNum]
