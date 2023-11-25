extends Scene
class_name MapScene

signal onBatSceneDel(isWin)
signal onBat()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera :Camera2D= $Camera2D
onready var fog :TileMap= $fog

const cs = ["#304d80","#2c4778","#254174","#1c3767","#1a3565","#326782","#87a254","#c8bf95","#ddd8c0","#efead5","#f7f4e7","#f9f8f2","#ffffff","#fffbe6","#fff5c1","#f5e9af","#f3e093","#f6cc88","#c79544","#b08546","#678296","#597285","#455e8c","#385488"]

var playFaci :Faci
var mapId = ""
var lv = 1

func init():
	.init()
	playFaci.connect("onSetCell",self,"rPlayerSetCell")
	sys.game.connect("onNextTime",self,"_nextTime")
	if mapId != sys.game.mainMapId :
		fog.modulate = Color.white
		$"%obFaci".hide()
	else:
		sys.addTip($"%obFaci","按类型筛选设施")
	playBgm()
	sys.addTip($"ui1/camCon/3",tr("镜头")+"\n"+tr("鼠标滚轮：缩放")+"\n"+tr("点击：指向玩家"))
	
func initFaci():
	for i in map.get_children():
		var faci = data.newBase(i.name.split("|")[0])
		faci.cell = world_to_map(i.global_position)
		addObj(faci)
	#if mapId == sys.game.mainMapId :
	map.initFaci()
	
func initMap(id,cell):
	mapId = id
	self.playFaci = Faci.new()
	playFaci.name = "你的部队"
	
	map.queue_free()
	if id == sys.game.mainMapId :
		#map = load("res://tscn/map/worldMap.tscn").instance()
		map = load("res://tscn/map/worldMap.tscn").instance()
		add_child_below_node($bg,map)
		map.mapId = id
		if sys.hasFile(sys.game.dataDir + "/%s.map" % mapId) :  #是否有地皮档
			map.loadMap()
		else:
			map.newMap()
	elif id.split("_")[0] == "rndMap" :
		if sys.game.mode == "tower" :
			map = load("res://tscn/map/towerMap.tscn").instance()
		else:map = load("res://tscn/map/dungeonMap.tscn").instance()
		add_child_below_node($bg,map)
		map.mapId = id
		if sys.hasFile(sys.game.dataDir + "/%s.map" % mapId) :  #是否有地皮档
			map.loadMap()
		else:
			map.newMap()
	
	else:
		map = data.newRes(id).instance()
		add_child_below_node($bg,map)
	
	playFaci.cell = cell
	init()
	playFaci.scene = self
	
	if sys.hasFile(sys.game.dataDir + "/%s.data" % mapId) :  #是否有地图档
		loadData()
	else:
		#迷雾
		for i in map.get_used_cells():
			fog.set_cellv(i,0)
		#sys.game.emit_signal("onInitFaci")
		initFaci()
	addPlayerFaci(playFaci)
	playFaci.glow = true
	objs.delItem(playFaci) #把玩家设施排除列表
	if id != sys.game.mainMapId:
		for i in getCells(playFaci.cell,2):
			upCell(i)
	camera.position = playFaci.position
	camera.reset_smoothing()
	
func loadMap():
	pass

func addObj(obj,cell = Vector2.ZERO):
	var faciV = preload("res://tscn/map/faciV.tscn").instance()
	objMap.add_child(faciV)
	obj.scene = self
	.addObj(obj,obj.cell)
	faciV.init(obj)
	if fog.get_cellv(obj.cell) == -1 :
		obj.visible = true
	
func addPlayerFaci(obj):
	var faciV = preload("res://tscn/map/playerFaciV.tscn").instance()
	objMap.add_child(faciV)
	obj.scene = self
	.addObj(obj,obj.cell)
	faciV.init(obj)

func _cellPressed(cell):
	var faci = matObj(cell)
	if faci != null && faci.isPressed :
		playFaci.goalCell = null
	if fog.get_cellv(cell) == -1:
		playFaci.goalCell = cell

func _physics_process(delta):
	if playFaci.goalCell != null :
		var obj = matObj(playFaci.goalCell)
		if obj != null && playFaci.distanceTo(obj) <= 1:
			playFaci.goalCell = null
			sys.eventDlg.tile.text = obj.name
			obj.trig()
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	if direction != Vector2.ZERO :
		camera.smoothing_speed = 5
		camera.position += direction * 10		
	

var oldCell
func rPlayerSetCell():
	if oldCell != playFaci.cell :
		oldCell = playFaci.cell
		if mapId == sys.game.mainMapId :
			sys.game.nextTime()
		sys.game.emit_signal("onPlayerMove")
		for i in getCells(playFaci.cell,3 if sys.game.isNight() else 4):
			upCell(i)
		camera.smoothing_speed = 1.5
		camera.position = map_to_world(playFaci.cell)
		

func upCell(cell):
	if map.get_cellv(cell) != -1 :
		fog.set_cellv(cell,-1)
	var obj = matObj(cell)
	if obj is Obj :
		if obj.visible == false && playFaci != obj:
			sys.game.emit_signal("onFaciFound",obj)
		obj.visible = true

func relative(relative):
	camera.smoothing_speed = 20
	camera.position -= relative

func battle(enemyTeam:Team):
	emit_signal("onBat")
	var batScene = sys.newDlg("res://tscn/bat/batDlg.tscn")
	yield(get_tree().create_timer(0.1),"timeout")
	batScene.initTeam(enemyTeam)

var isNight
func _nextTime():
	var tw = create_tween()
	tw.tween_property(map,"modulate", Color(cs[sys.game.time]), 0.3)
	isNight = sys.game.isNight()

func _on_mapScene_tree_entered():
	sys.mapScene = self
	pass # Replace with function body.

func getSave():
	var ds = {
		objs = objs.getSave(),
		fogs = fog.get_used_cells(),
		cell = sys.player.cell,
	}
	return ds

func setSave(ds):
	var objsl = ItemPck.new().setSave(ds.objs)
	for i in ds.fogs:
		fog.set_cellv(i,0)
	for i in objsl.items :
		addObj(i)
	return self

func saveData():
	var file = File.new()
	file.open(sys.game.dataDir + "/%s.data" % mapId,File.WRITE)
	file.store_var(getSave())
	file.close()

func loadData():
	var file = File.new()
	file.open(sys.game.dataDir + "/%s.data" % mapId,File.READ)
	var ds = file.get_var()
	file.close()
	setSave(ds)
	
func _on_k_gui_input(event:InputEvent):
	._on_k_gui_input(event)
	if  event is InputEventMouseButton :
		if event.button_index == BUTTON_WHEEL_UP:
			upCamera(-0.2)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			upCamera(0.2)
	if event.is_action_pressed("ui_accept") :
		_on_3_pressed()
var nowBgmFile = ""	
var nowBgmS = 0
func playBgm():
	if mapId == sys.game.mainMapId :
		nowBgmFile = "res://res/bgm/a%d.mp3" % sys.rndRan(1,5)
	else:
		nowBgmFile = "res://res/bgm/b%d.mp3" % sys.rndRan(1,5)
	sys.playBgm(nowBgmFile)
	
func pauseBgm(bl):
	if bl :
		nowBgmS = sys.bgm.get_playback_position()
	else:
		sys.playBgm(nowBgmFile,nowBgmS)

func _on_1_pressed():
	upCamera(4)

func _on_3_pressed():
	camera.zoom = Vector2.ONE
	camera.smoothing_speed = 1.5
	camera.position = map_to_world(playFaci.cell)

func _on_2_pressed():
	upCamera(-4)

func upCamera(v):
	camera.zoom.x = clamp(camera.zoom.x + v,1,10)
	camera.zoom.y = clamp(camera.zoom.y + v,1,10)
	$ui1/camCon/HSlider.value = camera.zoom.x

func _on_HSlider_value_changed(value):
	camera.zoom = Vector2.ONE *value

func _on_obFaci_item_selected(index):
	sys.game.faciSiftInx = index
