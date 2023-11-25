extends Conter
class_name Faci  #地图上的设施和事件

signal onSetGlow()
signal onSetIsCs()
signal onPressed()
signal onSetInvalid()

var glow = false setget setGlow #是否发光
var isCs = false setget setIsCs #是否能传送

var isPressed = false #是否点击直接触发trig
var invalid = false setget setInvalid ;func setInvalid(val): #是否显示X图标
	invalid = val;emit_signal("onSetInvalid")

var isInit = false
var baseFaciId = ""
var isShowIco = true
var createLv =  0
var dnum = 0

func _initInfo():
	pass

func _init():
	lvPerVal = 0.5
	visible = false

func loadInfo(id):
	self.id = id
	icoId = "ico_%s" % id
	_data()
	self.lv = lv
	_dataEnd()

func setGlow(val):
	glow = val
	emit_signal("onSetGlow")
	
func setIsCs(val):
	isCs = val
	emit_signal("onSetIsCs")

func _trig():
	pass

func forBuff(id = "",lv = 10):
	var bf
	if id == "" : 
		bf =  rnp.buffPool.rndItem(self,"rfBuff")
		id = bf.id
	else:bf = data.newBase(id)
	for cha in sys.player.team.chas:
		cha.castBuff(cha,id,lv)
#全队附加负面buff（id：buff的id 如果为“”则随机，lv ：层数）
func forDeBuff(id = "",lv = 2):
	var bf
	if id == "" : 
		bf =  rnp.buffPool.rndItem(self,"rfDeBuff")
		id = bf.id
	else:bf = data.newBase(id)
	for cha in sys.player.team.chas:
		cha.castBuff(cha,id,lv)

func rfBuff(buff):
	if buff.hasTab("buff") :return true
	return false

func rfDeBuff(buff):
	if buff.hasTab("deBuff") :return true
	return false
	
func rndLv(lv,minLv = 1,maxLv = 999):
	var rlv = 1
	for i in lv :
		var v = rnp.lvPool.rndItem()
		if v > rlv : rlv = v
	return clamp(rlv,minLv,maxLv)
	
#取随机装备（价值等级） 这个等级不等于固定等级
func getRndEqp(lv,minLv = 0,maxLv = 9):
	var item = data.newBase(rnp.eqpPool.rndItem().id)
	return item.createRndLv(lv,minLv,maxLv)
var rs
#获取遗物对话框
func relicDlg():
	sys.eventDlg.selRelic(relicGet()).reUpBtn.link(15,self,"relicGet")
func relicGet():
	rs = []
	for i in 4 :
		var rv =  data.newBase(rnp.relic.rndItem(self,"rndRelicDlg").id)
		rv.lv = 1
		rs.append(rv)
	return rs
func rndRelicDlg(item):
	var pr = sys.player.relics.hasIdItem(item.id)
	if pr != null && pr.lv >= pr.maxLv : return false
	for i in rs :
		if i.id == item.id :return false
	return true
#获取装备对话框
func eqpSelDlg(lv = 1):
	eqpLv = lv
	sys.eventDlg.selItem(eqpSelGet()).reUpBtn.link(10,self,"eqpSelGet")
var eqpLv = 1
func eqpSelGet():
	rs = []
	for i in 3 :
		var rv = data.newBase(rnp.eqpPool.rndItem(self,"rndItemSelDlg").id) 
		rv.create(eqpLv)
		rs.append(rv)
	return rs
	
#获取宝石对话框
func ugemSelDlg(lv = 4):
	ugemLv = lv
	sys.eventDlg.selItem(ugemSelGet()).reUpBtn.link(10,self,"ugemSelGet")
var ugemLv = 2
func ugemSelGet():
	rs = []
	for i in 3 :
		var rv = data.newBase(rnp.gemUnPool.rndItem(self,"rndItemSelDlg").id)
		rv.lv = clamp(ugemLv,2,6)
		rs.append(rv)
	return rs
	
func rndItemSelDlg(item):
	for i in rs :
		if i.id == item.id :return false
	return true
	
func trig():
	if isInit == false :
		_initInfo()
		isInit = true
	_trig()

func _pressed():
	if isPressed :
		trig()

#触发设施，并附加信息
func trigInfo(id = "",info = ""):
	sys.game.emit_signal("onTrigFaci",self,id,info)

func cs():
	sys.mapScene.playFaci.matMoveUp(cell)
	sys.mapScene.playFaci.goalCell = null

func _createStart():
	pass
	
func _create():
	pass

#创建条件
func _createIf():
	return true

func getSave():
	var ds = {
		isInit = isInit,
		invalid = invalid,
		isCs = isCs,
		isShowIco = isShowIco,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("isInit",ds)
	dsSet("invalid",ds)
	dsSet("isCs",ds)
	dsSet("isShowIco",ds)
