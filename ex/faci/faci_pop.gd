extends FaciBat

func _data():
	name = "灵魂圣杯"
	dec = "增加一个人口上限"
	weight = 0.5
	tab = "world"
	num = nums.size()
	
const nums = [1,2,3]
	
func _in():
	lv = 0
	
func _trig():
	sys.eventDlg.txt(tr("拿到灵魂圣杯，它使你的 人口上限 +1"))
	sys.player.maxPopl += 1
	del()
	
func _createStart():
	createLv = nums[0]
	nums.remove(0)

