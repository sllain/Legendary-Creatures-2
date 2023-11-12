extends Skill

var dmg = 0

func _data():
	name = "生命湍流"
	cd = 0
	tab = "肉霸"
	
func getDec():
	return tr("战斗前和战斗后，恢复%d%%最大生命值，且承受的治疗效果提高%d%%") %  [per(0.25)*100,30]

func _in():
	sys.game.connect("onBattleReady",self,"r")
	sys.game.connect("onBattleEnd",self,"rEnd")
	masCha.connect("onPlusStart",self,"r2")

func r2(info):
	if info.type == "hp":
		info.per += per(0.3)

func r():
	var eff = mas.scene.newEff("e_zhiLiaoShu", mas.position, mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	masCha.plusHp(masCha.maxHp * per(0.25))

func rEnd(b):
	r()
