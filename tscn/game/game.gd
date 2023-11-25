extends Control
class_name Game

signal onChaHurtStart(atkInfo)  #被伤害前（攻击信息）
signal onChaHurt(atkInfo)  #被伤害后（攻击信息）
signal onChaCastHurtStart(atkInfo) #造成伤害前（攻击信息）
signal onChaCastHurt(atkInfo)  #造成伤害后（攻击信息）
signal onChaPlusStart(info)  #回复生命值（回复信息）
signal onChaCastPlusStart(info)  #施放回复生命值（回复信息）
signal onChaPlus(info)  #回复生命值（回复信息）
signal onChaCastPlus(info)  #施放回复生命值（回复信息）
signal onChaDeathStart(atkInfo)
signal onChaDeath(atkInfo)
signal onChaKillStart(atkInfo)
signal onChaKill(atkInfo) 
signal onChaCastSkill(skill) #施放主动技能时（角色,施放的技能）
signal onChaCastBuff(buff) #有单位为目标附加buff
signal onChaAddBuff(buff) #有单位获得buff
signal onChaPlusLv(cha)
signal onChaFire(cha) #解雇

signal onBattleReady()
signal onBattleStart()
signal onBattleEndStart(isWin)
signal onBattleEnd(isWin)
signal onChaInScene(cha)

signal onNextTime()
signal onNextDay()
signal onToMap(mapId)
signal onOutDungeon()
signal onPlayerMove()
signal onBuyItem(item) #购买物品时
signal onTrigFaci(faci,id,info) #触发设施状态时，需要设施内部自行触发 (设施，信息)

signal onNewGame()
signal onEnd(isWin) #游戏结束（是否胜利）

signal onFaciFound(faci)	#设施被发现时	
signal onUpS()

var time = 6  #当前小时
var timeNext = 0.3334 setget setTimeNext#每步推进时间
var day = 1 #当前天
var spd = 1.0
var isTimeOn = true #时间流失开启
var diffLv = 0

var mapId = "map_00"
var mainMapId = "map_00" 

var rndDungeonNum = 0
var playerCell = Vector2.ZERO

var player = Player.new()
var dataDir = ""
var globals = {} #全局事件表

var faciSiftInx = 0
var plusCryNum = 0
var mode = "map"

func setTimeNext(val):
	timeNext = val

# Called when the node enters the scene tree for the first time.
func _ready():
	dataDir = sys.main.dataDir
	
func newGame():
	sys.main.initSaveDir()
	sys.game = self
	sys.player = player
	player.inStart(null)
	player.newData()
	rnp.init()
	_gInit()
	_gInStart()
	$ui/home.init()
	toMapBase(mapId,Vector2(10,10))
	sys.mapScene.playFaci.matMoveUp(player.cell)
	sys.eventDlg = sys.newDlg("res://tscn/eventDlg/eventDlg.tscn")
	sys.eventDlg.hide()
	emit_signal("onNewGame")
	
func loadGame():
	sys.game = self
	sys.player = player
	_gInit()
	loadData()
	player.loadData()
	_gInStart()
	player.inStart(null)
	rnp.init()
	$ui/home.init()
	toMapBase(mapId,playerCell)
	sys.eventDlg = sys.newDlg("res://tscn/eventDlg/eventDlg.tscn")
	sys.eventDlg.hide()
	
func _gInit():
	for i in data.getList("g"):
		var g = data.newBase(i.id) 
		if g.checkMode(mode) == false:continue
		if g.lock == 1 : 
			globals[g.id] = g
func _gInStart():
	for i in globals.values():
		i.inStart(self)		
	$ui/home/gbox.init()
	
func plusCry(n):
	plusCryNum += n
	
var ups = 0.0
func _physics_process(delta):
	ups += delta
	if ups >= 1:
		ups = 0.0
		emit_signal("onUpS")
	for i in globals.values():
		i._process(delta)
	
func _on_game_tree_entered():
	pass
	
func _input(event):
	if sys.isTest :
		if event.is_action_pressed("ui_1") :
			sys.player.items.addItem(data.newBase("m_gold").setNum(1000))
		elif event.is_action_pressed("ui_2") :
			sys.player.items.addItem(data.newBase("m_xp").setNum(1000))
		elif event.is_action_pressed("ui_3") :
			sys.player.items.addItem(data.newBase("m_cry").setNum(100))
		
		elif event.is_action_pressed("ui_4") :
			var item = data.newBase("m_eMoSoul")
			sys.player.items.addItem(item)
		
		elif event.is_action_pressed("ui_5") :
			var item = data.newBase(rnp.eqpPool.rndItem().id)
			item.create(4)
			sys.player.items.addItem(item)
			
		elif event.is_action_pressed("ui_0") :
			for i in data.getList("c"):
				var cha = data.newBase(i.id)
				#if cha.lock == -1 :continue
				cha.cell = Vector2(6,0)
				cha.team = self
				sys.player.addAlterCha(cha)
		
		elif event.is_action_pressed("ui_5") :
			for i in data.getList("csb"):
				var item = data.newBase(i.id)
				sys.player.items.addItem(item)
		elif event.is_action_pressed("ui_6") :
			for i in data.getList("r") :
				var item = data.newBase(i.id)
				sys.player.relics.addItem(item)
				
		elif event.is_action_pressed("ui_7") :
			var item = data.newBase("csb_heDang")
			sys.player.items.addItem(item)
			
		elif event.is_action_pressed("ui_8") :
			var item = data.newBase(rnp.gemPool.rndItem().id)
			sys.player.items.addItem(item)
		elif event.is_action_pressed("ui_end") :
			end(true)
		elif event.is_action_pressed("ui_page_down") :
			nextTime(24)
	
func toMap(id,cell = null,lv = 1):
	saveGame()
	toMapBase(id,cell,lv)
	call_deferred("saveGame")
	
func toMapBase(id,cell = null,lv = 1):
	if is_instance_valid(sys.mapScene) :
		sys.mapScene.queue_free()
	var scene :MapScene
	scene = load("res://tscn/map/mapScene.tscn").instance()
	add_child(scene)
	scene.lv = lv
	scene.initMap(id,cell)
	mapId = id
	emit_signal("onToMap",mapId)
	
func getRndDungeonId(id = ""):
	if id == "" :
		rndDungeonNum += 1
		id = "rndMap_%d" % rndDungeonNum
	return id
#回大地图	
func hc():
	toMap(mainMapId,sys.player.worldCell)
	emit_signal("onOutDungeon")

func nextTime(val = 0):
	if isTimeOn == false:return
	if val == 0 :val = timeNext
	time += val
	if time >= 24 :
		time = int(time)
		nextDay(int(time / 24)) 
		time = time % 24
	emit_signal("onNextTime")
		
func nextDay(val):
	day += val
	emit_signal("onNextDay")
	if sys.isDemo && day >= sys.demoDay:
		yield(sys.newMsg(tr("试玩版只能体验到%d天，谢谢游玩") % sys.demoDay),"onDel")
		sys.game.end(false)

func isNight():
	if time >= 19 || time <= 5 :
		return true
	return false
	
func isMainMap():
	return mapId == mainMapId
	
func end(isWin):
	sys.mapScene.playFaci.goalCell = null
	emit_signal("onEnd",isWin)
	var dlg = sys.newDlg("res://tscn/game/gameEndDlg.tscn")
	dlg.init(isWin)
	
func connect(sig,target,method,binds=[],flags=0):
	if is_connected(sig,target,method) == false:
		.connect(sig,target,method,binds,flags)

func disconnect(sig,target,method):
	if is_connected(sig,target,method):
		.disconnect(sig,target,method)

func getSave():
	var gs = []
	for i in globals:
		var g = globals[i].getSave()
		gs.append(g)
	var ds = {
		time = time,
		day = day,
		mapId = mapId,
		rndDungeonNum = rndDungeonNum,
		spd = spd,
		playerCell = sys.mapScene.playFaci.cell,
		gs = gs,
		diffLv = diffLv,
		plusCryNum = plusCryNum,
		mode = mode,
		seedVal = sys.rndRan(0,10000),
		achs = achs.getSave(),
	}
	return  ds
	
func setSave(ds:Dictionary):
	time = ds.time
	day = ds.day
	mapId = ds.mapId
	spd = ds.spd
	playerCell = ds.playerCell
	rndDungeonNum = ds.rndDungeonNum
	diffLv = ds.diffLv
	dsSet("plusCryNum",ds)
	dsSet("mode",ds)
	if ds.has("seedVal") :
		seed(ds.seedVal)
	for i in ds.gs :
		globals[i.id].setSave(i)
	if ds.has("achs") :
		achs.setSave(ds.achs)
		for i in achs.items:
			i._ach()
			
func dsSet(id,ds):
	if ds.has(id) :
		set(id,ds[id])
	
func saveGame():
	var dir = Directory.new()
	dir.make_dir_recursive(dataDir)
	saveData()
	sys.player.saveData()
	if is_instance_valid(sys.mapScene) :
		sys.mapScene.saveData()
	
func saveData():
	var file = File.new()
	file.open(sys.game.dataDir + "/game.data",File.WRITE)
	file.store_var(getSave())
	file.close()

func loadData():
	var file = File.new()
	file.open(sys.game.dataDir + "/game.data",File.READ)
	var ds = file.get_var()
	file.close()
	setSave(ds)

var achs :ItemPck = ItemPck.new()

func ach(item):
	if item.lock == 0 && item.lockType == 1 && data.lockDs.has(item.id) == false:
		if achs.hasIdItem(item.id) == null:
			achs.addItem(item)
			item._ach()
