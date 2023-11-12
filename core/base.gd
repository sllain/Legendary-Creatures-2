## @class
extends Reference
class_name Base

signal onSetDec()#描述被修改时
signal onDel() #被移除时
signal onSetLv() #等级改变时
signal onExit() #从itemPck 移除时
signal onEnter() #从itemPck 进入时
signal onSetNum()

var name = ""
var dec = "" setget setDec,getDec
func setDec(val):
	dec = val
	emit_signal("onSetDec")
func getDec():return dec

var id = ""
var insId = 0
var mas:Base = null
var lv = 1 setget setLv; func setLv(val):
	if val < 0 :val = 0
	lv = val
	emit_signal("onSetLv")
var lvPerVal = 0.20
var tab = ""
var isNum = false
var weight = 1
var num = 1 setget setNum
var scene
var lock = 1 #解锁状态 -1 从不出现在池中，0 未解锁，1 已解锁
var lockVal = 50 #解锁的费用
var lockType = 0 #解锁方式 0 魂解锁，1 成就解锁
var achDec = "" 
var isDel = false 
var excMode = "" #从该模式中排除

enum ATKTYPE {NORMAL,SKILL,EFF}
enum HURTTYPE {PHY,MAG,REAL}

func checkMode(mode):
	return excMode.find(mode) == -1

func _data():
	pass
	
func _dataEnd():
	pass

func loadInfo(id):
	self.id = id
	_data()
	self.lv = lv
	_dataEnd()

func inStart(mas):
	self.mas = mas
	_in()
	
func _in():
	pass

var isAchCom = false
func _ach():
	pass
func achCom():
	if isAchCom :return
	isAchCom = true
	data.achUlock(self)
	
func setNum(val):
	num = val
	emit_signal("onSetNum")
	return self
	
func del():
	delAllConnect()
	delEnd()
	emit_signal("onDel")
	isDel = true

func delEnd():
	_del()
	
func _del():
	pass
	
func saveProp():
	return 
	
func getSave():
	var ds = {
		id=id,
		lv=lv,
		insId = get_instance_id(),
		isDel=isDel,
	}
	return ds

func setSave(ds):
	dsSet("id",ds)
	dsSet("lv",ds)
	dsSet("isDel",ds)

func dsSet(id,ds):
	if ds.has(id) :
		set(id,ds[id])

#按等级比率增加数值
func lvPer(lv,baseVal,val = 0):
	if val == 0 : val = lvPerVal
	return baseVal * (1.0 + (lv-1) * val)
#按自身等级比率增加数值
func per(val):
	return val * (1.0 + (lv-1) * lvPerVal)

#是否包含所有标签 tabs 可以是多个标签如“xxx xxx”
func hasTab(tabs):
	for i in tabs.split(" "):
		var b = false
		for j in tab.split(" "):
			if i == j :
				b = true
				continue
		if !b :return false
	return true
	
#是否包含其中一个 tabs 可以是多个标签如“xxx xxx”
func hasOrTab(tabs):
	for i in tabs.split(" "):
		for j in tab.split(" "):
			if i == j :
				return true
	return false
	
func trTab():
	var t = ""
	for i in tab.split(" "):
		t += tr(i) + " "
	return t
func connect(sig,target,method,binds=[],flags=0):
	if is_connected(sig,target,method) == false:
		.connect(sig,target,method,binds,flags)

func disconnect(sig,target,method):
	if is_connected(sig,target,method):
		.disconnect(sig,target,method)
	
func delAllConnect():
	for i in get_incoming_connections ():
		i["source"].disconnect(i["signal_name"],self,i["method_name"])	
	
#百分比随机5
static func rndPer(var val):
	if randf() <= val :
		return true
	return false
#范围随机	
static func rndRan(mmin,mmax):
	var d = mmax - mmin + 1
	if d == 0 :return mmin
	return randi()%(d) + mmin
#随机	
static func rnd(val):
	return randi()%val
#从列表中随机一个元素
static func rndListItem(list):
	if list.size() > 0:
		return list[rnd(list.size())]
	return null
#创建并返回一个计时器 多用于协程 yield
func ctime(time) -> SceneTreeTimer  :
	return sys.get_tree().create_timer(time)

