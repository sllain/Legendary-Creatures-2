extends Buff

func _data():
	name = "坚如磐石"
	isDie = false
	isLong = true
	maxLv = 50
	tab = ""
	lock = -1

func allySetDef(val):
	self.def += val
  
func _in():
	sys.game.connect("onBattleEnd",self,"battleEnd")
	
func battleEnd(isWin):
	del()
