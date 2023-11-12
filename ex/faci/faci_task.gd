extends Faci

func _data():
	name = "先知"
	dec = "接取引导任务！"
	weight = 1
	num = 1
	tab = "world"
	isCs = true
	glow = true

func _trig():
	sys.game.globals.g_task.next()
	del()
	
func _in():
	lv = 0
	yield(ctime(0.1),"timeout")
	matMoveUp(sys.mapScene.getNullCell(sys.mapScene.playFaci.cell + Vector2(1,1)))
	self.visible = true
