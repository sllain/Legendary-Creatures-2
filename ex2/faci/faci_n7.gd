extends Faci

func _data():
	name = "晶石交换"
	dec = "用晶石换取金币或魂"
	weight = 1
	tab = "world"
	num = 2
	lockType = 1
	lock = 0
	achDec = "通关难度7"

func _trig():
	var g = per(50)
	var g1 = per(1000)
	var g2 = per(250)
	sys.eventDlg.txt(tr("你想用%d晶石换取什么？" % g),true)
	var inx = yield(sys.eventDlg.selBB([tr("%d 金币") % g1,tr("%d 魂") % g2,"离开"]),"onSel")
	if inx == 2 :return
	if sys.player.subItem("m_cry",g) == false:
		sys.eventDlg.txt("晶石 不足")
		return
	var itemPck = ItemPck.new()
	if inx == 0 :
		itemPck.addItem(data.newBase("m_gold").setNum(g1))
	elif inx == 1 :
		itemPck.addItem(data.newBase("m_xp").setNum(g2))
	sys.eventDlg.items(itemPck)
	del()

func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 7 :
		achCom()

const nums = [2,3]
	
func _createStart():
	createLv = nums[0]
	nums.remove(0)
