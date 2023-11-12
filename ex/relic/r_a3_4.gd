extends Relic

func _data():
	name = "百炼成钢"
	
func getDec():
	return tr("坦克每5秒，获得%d%%最大生命值的护盾") % [lvPer(lv,6)]

func _in():
	sys.game.connect("onUpS",self,"_upS")
	sys.game.connect("onBattleStart",self,"r")

func r():
	times = 0

var times = 0

func _upS():
	times += 1
	if times >= 5:
		times = 0
		if is_instance_valid(sys.batScene) && sys.batScene.isBattle :
			var chas = sys.batScene.getAllChas()
			for i in chas:
				if i == null:continue
				if i.team != sys.player.team :continue
				if i.hasTab("坦克"):
					i.plusWard(i.maxHp*lvPer(lv,0.06),i)
