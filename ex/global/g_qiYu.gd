extends Global

var nextMlv = 1
var maxMlv = 20

var faci :Faci= null

func _data():
	name = "奇遇"
	isVisIco = false
	lv = 0
	icoId = "ico_faci_unk"
	dec = "点击图标遭遇奇遇"
	excMode = "tower"

func _in():
	sys.game.connect("onNextDay",self,"_nextDay")
	#sys.game.connect("onNextTime",self,"_nextDay")
	if faci == null || faci.isDel :
		faciDel()

func _nextDay():
	lv += 1
	if lv > 2 :
		newFaci()
		lv = 0 

func newFaci():
	if faci != null :faci.del()
	faci = data.newBase(rnp.subPoolDs["faci_unk"].rndItem().id) 
	self.isVisIco = true
	faci.connect("onDel",self,"faciDel")
	faci._create()
	sys.newMsg(tr("出现了新的奇遇，点击屏幕上方的问号图标触发"))
	
func _pressed():
	if faci == null :return
	if faci.isDel :
		faciDel()
		return
	faci.trig()
	
func faciDel():
	faci = null
	self.isVisIco = false

func getSave():
	var fds = null
	if faci != null:
		fds = faci.getSave()
	var ds = {
		faci = fds,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	if ds.faci != null:
		faci = data.newBase(ds.faci.id)
		faci.setSave(ds.faci)
