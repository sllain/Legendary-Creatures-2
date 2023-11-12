extends Skill

var dmg = 0

func _data():
	name = "血肉凝结"
	cd = 0
	tab = "肉霸"

var plHp = 0
	
func getDec():
	return tr("每场非普通战斗的胜利永久提升 %d点最大生命值") %  [per(25)]

func _in():
	sys.game.connect("onBattleEnd",self,"rEnd")
	self.maxHp = plHp

func rEnd(isWin):
	if isWin && is_instance_valid(sys.batScene)  && sys.batScene.faci.name != "普通敌人":
		plHp += per(25)

func getSave():
	var ds = {
		plHp = plHp,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("plHp",ds)
