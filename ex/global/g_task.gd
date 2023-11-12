extends Global

var state = 0 #进度状态
var isCom = false

func _data():
	name = "引导任务"
	txt = ""
	icoId = "ico_faci_task"
	self.isVisIco = false
	excMode = "tower"

func _in():
	self.lv = 0
	_con()

func start(tid):
	self.isVisIco = true
	self.tid = tid
	self.txt = ""
	state = 0
	_con()

func _con():
	if isCom :return
	if state == 1 :
		self.dec = "在城镇或者其他渠道雇佣一个单位。"
		sys.player.connect("onAddAlterCha",self,"_a1")
	elif state == 2 :
		self.dec = "获得足够的魂，升级一个单位。"
		sys.game.connect("onChaPlusLv",self,"_a2")
	elif state == 3 :
		self.dec = "发现并进入一个地牢。"
		sys.game.connect("onToMap",self,"_a3")
	elif state == 4 :
		self.dec = "找到并击败3名魔王仆从。"
		sys.game.globals.g_puCong.connect("onBossDel",self,"_a4")

func com():
	delAllConnect()
	self.isCom = true
	self.isVisIco = true
	self.txt = "完成"
	self.dec = "完成引导任务！点击引导任务的图标领取奖励"
	sys.newMsg(dec)
	
func _pressed():
	if isCom :
		next()
	
func next():
	state += 1
	self.isCom = false
	self.isVisIco = true
	self.txt = ""
	_con()
	if state == 0 :
		pass
	elif state == 1 :
		sys.eventDlg.txt(tr("请合理的规划路线，在地图中移动和战斗都会使时间流逝，海拔越高怪物越强。") + "\n" + tr("每过1天，瘴气会提高1级。"))
		sys.eventDlg.txt("%s\n%s" % [tr("接下来请完成如下任务："),tr(self.dec)])
	elif state == 2 :
		sys.eventDlg.txt("完成任务！获得奖励。")
		eqpSelDlg(state)
		sys.eventDlg.txt("%s\n%s" % [tr("点击城镇以其他有小箭头的设施可以直接传送，接下来请完成："),tr(self.dec)])
	elif state == 3 :
		sys.eventDlg.txt("完成任务！获得奖励。")
		eqpSelDlg(state)
		sys.eventDlg.txt("%s\n%s" % [tr("接下来请完成如下任务："),tr(self.dec)])
	elif state == 4 :
		sys.eventDlg.txt("完成任务！获得奖励。")
		eqpSelDlg(state)
		sys.eventDlg.txt("%s\n%s" % [tr("你已经踏上了成王之路，最后请完成任务："),tr(self.dec)])
		_a4()
	elif state == 5 :
		sys.eventDlg.txt(tr("你已经完成了所有引导任务，也凝聚一支强力的队伍，证明了你成为王的资格。"))
		sys.eventDlg.txt(tr("这是授予给你的。"))
		var items := ItemPck.new()
		var item = data.newBase(rnp.eqpoPool.rndItem(self,"rndEqpo").id) 
		rnp.eqpoPool.delItem(item)
		items.addItem(item)
		sys.eventDlg.items(items)
		end()
	
func end():
	state = -1
	self.isVisIco = false
	
func rndEqpo(item:Eqp):
	return item.hasTab("国王")

var rs 
func eqpSelDlg(lv = 1):
	rs = []
	for i in 3 :
		var rv = data.newBase(rnp.eqpPool.rndItem(self,"rndItemSelDlg").id) 
		rv.create(lv)
		rs.append(rv)
	sys.eventDlg.selItem(rs)
	
func rndItemSelDlg(item):
	for i in rs :
		if i.id == item.id :return false
	return true

func _a1(cha):
	com()
	
func _a2(cha):
	if cha.team == sys.player.team :
		com()
	
func _a3(id):
	if  sys.game.mainMapId != id:
		com()
		
func _a4():
	var n = sys.game.globals.g_puCong.delN
	self.txt = "%d/%d" % [n,3]
	if n >= 3 :
		com()

func getSave():
	var ds = {
		isCom = isCom,
		state = state,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("isCom",ds)
	dsSet("state",ds)
