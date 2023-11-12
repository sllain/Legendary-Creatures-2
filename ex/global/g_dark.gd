extends Global

func _data():
	name = "幽暗值"
	txt = "0"
	excMode = "tower"
	
var darkDs = {}
var nowId = ""
var bossDeath = false
var maxLv = 30

func setLv(val):
	.setLv(val)
	var s = tr("当前幽暗值%d") % lv + "\n"
	s += tr("敌方增加%d%%的增伤和减伤") % lv + "\n"
	s += tr("在地牢中战斗时间减少，但是会增加幽暗值") + "\n"
	self.dec = s
	self.txt = "%d" % lv

func _in():
	sys.game.connect("onToMap",self,"_toMap")
	sys.game.connect("onBattleReady",self,"_bat")
	sys.game.connect("onPlayerMove",self,"_move")
	sys.game.connect("onBattleEnd",self,"_batEnd")
	
func _toMap(id):
	if sys.game.isMainMap() == false :
		if darkDs.has(id) == false:
			darkDs[id] = 0
		self.lv = darkDs[id]
		nowId = id
		bossDeath = false
	elif bossDeath:
		for i in sys.mapScene.objs.items: 
			if i is FaciDungeon && nowId == i.dId :
				i.invalid = true
				break
	self.isVisIco = !sys.game.isMainMap()
	
func _bat():
	if sys.game.isMainMap() == false && lv > 0:
		for i in sys.batScene.getAllChas():
			if i.team != sys.player.team :
				i.castBuff(i,"b_a_dark",lv)

func _move():
	if sys.game.isMainMap() == false:
		if self.lv < maxLv :
			self.lv += 1
			darkDs[nowId] += 1
		self.isVisIco = !sys.game.isMainMap()
		
func _batEnd(win):
	if win && sys.batScene.faci != null && sys.batScene.faci.id == "faci_batBoss":
		bossDeath = true
	
		
func getSave():
	var ds = {
		nowId = nowId,
		darkDs = darkDs,
		bossDeath = bossDeath,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("nowId",ds)
	dsSet("darkDs",ds)
	dsSet("bossDeath",ds)
