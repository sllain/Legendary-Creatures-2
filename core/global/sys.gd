extends Node
class_name Sys

var main :Main 
var game :Game
var mapScene :MapScene
var batScene :BatScene
var player :Player
var eventDlg  :EventDlg
onready var bgm = $AudioStreamPlayer

var dataDir = "user://data1"
var isTest = OS.has_feature("editor")
var quDao = "steam"
var godotSteam = null
var lockDiffLv = 0 #当前解锁的到的难度
var lockDiffLvTower = 0 #当前解锁到的难度 爬塔模式

var bgmVol = 0.7 setget set_bgmVol
var seVol = 0.7 setget set_seVol
var lg = "zh_CN" setget set_lg
var lgDs = {
	schinese="zh_CN",
	tchinese="zh_HK",
	english="en",
	japanese="ja",
}
var isLight = true

var isMin = false
var isDemo = false
var isBeta = OS.has_feature("editor")
var isMod = OS.has_feature("editor")

var demoDay = 15

func _ready():
	pass
	
#按等级比率增加数值
func lvPer(lv,baseVal,val):
	return baseVal * (1 + (lv-1) * val)

func newMsg(txt,isSel = false):
	var msg = load("res://tscn/base/msgDlg.tscn").instance()
	main.ui.add_child(msg)
	msg.init(tr(txt),isSel)
	msg.popup()
	if is_instance_valid(sys.mapScene):
		sys.mapScene.playFaci.goalCell = null
	return msg
	
func newDlg(file):
	var dlg = load(file).instance()
	main.ui.add_child(dlg)
	dlg.popup()
	return dlg
	
func addTip(node,txt):
	sys.main.addTip(node,tr(txt))

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
#返回时间字符串	
func getTimeStr(time):
	 return "%02d : %02d" % [int(time),(time-int(time) ) * 60]

func dsSet(id,ds):
	if ds.has(id) :
		set(id,ds[id])

func hasFile(file):
	var dir = Directory.new()
	return dir.file_exists(file)
	
func playBgm(file,s= 0):
	bgm.stream = load(file)
	bgm.play(s)
	
#func playBgmMp3(file):
#	var f  = File.new()
#	if f.open(file,File.READ) ==  OK :
#		var stream = AudioStreamMP3.new()
#		stream.data = f.get_buffer(f.get_len())
#		bgm.stream = stream
#		stream.loop = false
#		bgm.play()
#		f.close()
var oldSeFile = []
func playSe(file,bd = 0,absPath = false):
	if absPath == false :
		file = "res://res/se/" + file
	if file in oldSeFile : return
	oldSeFile.append(file)
	var se = load("res://tscn/main/se.tscn").instance()
	add_child(se)
	se.volume_db = bd
	se.init(file)
	
func playSeMp3(file):
	var se = load("res://tscn/main/se.tscn").instance()
	add_child(se)
	se.initMp3(file)

var seS = 0.0
func _physics_process(delta):
	seS += delta
	if seS > 0.5 :
		oldSeFile.clear()
		seS = 0
	
func set_bgmVol(val):
	bgmVol = val
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Bgm"),10*log(val) + 6)
	
func set_seVol(val):
	seVol = val
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Se"),10*log(val) + 6)
	
func set_lg(val):
	if val == "" :
		if sys.godotSteam != null :
			var key = sys.godotSteam.getSteamUILanguage()
			if lgDs.has(key) :
				val = lgDs[key]
			else:
				val = "en"
			print(key," ",val)
		else:
			val = "zh_CN"
	lg = val
	TranslationServer.set_locale(val)
	cons.init()

func loadInfo():
	var file = File.new()
	if  file.open("%s/info.data" % sys.dataDir, File.READ) == OK :
		var dic = file.get_var()
		file.close()
		if dic == null:
			print_debug("读取存档错误")
			return
		lockDiffLv = dic.lockDiffLv
		if dic.has("lockDiffLvTower"):lockDiffLvTower = dic["lockDiffLvTower"]
		if dic.has("bgmVol"):bgmVol = dic["bgmVol"]
		if dic.has("seVol"):seVol = dic["seVol"]
		if dic.has("lg"):lg = dic["lg"]
		if dic.has("window_size"):OS.window_size =dic.window_size
		if dic.has("window_fullscreen"):OS.window_fullscreen = dic.window_fullscreen
		if dic.has("isLight"):isLight = dic["isLight"]
		set_bgmVol(bgmVol)
		set_seVol(seVol)
		set_lg(lg)
		return dic
	else:
		set_lg("")
		OS.window_size = Vector2(1600,800)
		
func saveInfo():
	var file = File.new()
	var dir = Directory.new()
	dir.make_dir_recursive("%s" % sys.dataDir)
	var dic = {
		lockDiffLv = lockDiffLv,
		lockDiffLvTower = lockDiffLvTower,
		bgmVol=bgmVol,
		seVol=seVol,
		lg = lg,
		window_size=OS.window_size,
		window_fullscreen=OS.window_fullscreen,
		isLight = isLight,
	}
	if file.open("%s/info.data" % sys.dataDir, File.WRITE) == OK:
		file.store_var(dic)
		file.close()

func _on_sys_tree_entered():
	isMin = OS.get_data_dir().find("steamuser") != -1
	if quDao == "steam" &&  OS.has_feature("editor") == false && isMin == false:
		godotSteam = load("res://sdk/steam/godotSteam.gd").new()
		sys.add_child(godotSteam)
		godotSteam.init()
	if "mod" in OS.get_cmdline_args():
		isMod = true
	loadInfo()
	if isMin :
		OS.window_size = Vector2(1280,720)
		OS.window_fullscreen = true
	OS.center_window()
	
