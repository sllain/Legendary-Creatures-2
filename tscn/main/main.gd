extends Control
class_name Main

onready var ui = $ui
onready var ui2 = $ui2
onready var tip = $ui2/tip
onready var txt = $ui2/tip/txt
onready var k = $ui2/tip/k

var dataDir = ""
var modsInfo = {}

class ModInfo:
	extends Resource
	var id = ""
	var dir = ""
	var file = ""

func _ready():
	if sys.isMod:
		sys.newDlg("res://tscn/mod/modManage.tscn")
	else:
		var tile = preload("res://tscn/tile/tile.tscn").instance()
		add_child(tile)

func printAtt(base):
	pass

func _on_mian_tree_entered():
	sys.main = self
	randomize()
	dataDir = sys.dataDir + "/game1"
	get_tree().connect("node_added",self,"_addNode")
	
func _addNode(node):
	if node is Button :
		node.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
		node.connect("pressed",self,"_btnPressed",[node])

var tipDs = {}

func _btnPressed(node:Button):
	if node.disabled == false:
		node.disabled = true
		yield(get_tree().create_timer(0.3),"timeout")
		if is_instance_valid(node) :node.disabled = false

func addTip(node:Control,txt):
	if tipDs.has(node) == false :
		tipDs[node] = txt
	else:
		tipDs[node] = txt
		if tip.visible && sNode == node: 
			self.txt.bbcode_text = tipDs[node]
		return
	if is_instance_valid(node) == false: return
	node.connect("mouse_entered",self,"showTip",[node])
	node.connect("mouse_exited",self,"hideTip")
	node.connect("visibility_changed",self,"hideTip")
	node.connect("tree_exiting",self,"delTip",[node])

var sNode = null
func showTip(node):
	if node == null:return
	#hideTip()
	var txt = tipDs[node]
	sNode = node
	self.txt.bbcode_text = ""
	self.txt.bbcode_text = txt
	tip.show()
	if self.txt.text.length() < 10 :
		self.txt.rect_size.x = self.txt.text.length() * 15
	else:
		self.txt.rect_size.x = 250
	self.txt.rect_size.y = 0
	tip.modulate = Color("#00ffffff")
	var tween = get_tree().create_tween()
	tween.tween_property(tip, "modulate", Color("#ffffff"), 0.15)
	#tween.tween_property(tip, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func hideTip():
	self.txt.rect_size.y = 0
	self.txt.bbcode_text = ""
	tip.modulate = Color("#ffffff")
	var tween = get_tree().create_tween()
	tween.tween_property(tip, "modulate", Color("#00ffffff"), 0.15)
	#tween.tween_property(tip, "scale", Vector2(1,0), 0.1).set_ease(Tween.EASE_OUT)
	tip.hide()

func delTip(node):
	tipDs.erase(node)
	hideTip()

func _process(delta):
	var x = clamp(k.get_global_mouse_position().x + 10,0,960-k.rect_size.x)
	var y = clamp(k.get_global_mouse_position().y + 10,0,480-k.rect_size.y)
	tip.position = Vector2(x,y)
	if self.txt.text.length() == 0 :tip.hide()
	k.rect_size = txt.rect_size + Vector2(10,10)

func endGame():
	delGame()
	
func delAllDlg():
	for i in ui.get_children():
		if i == sys.eventDlg : continue
		i.queue_free()
	
func delGame():
	if is_instance_valid(sys.game) : sys.game.queue_free()
	var tile = preload("res://tscn/tile/tile.tscn").instance()
	sys.main.add_child(tile)
	for i in ui.get_children():
		i.queue_free()

func initSaveDir():
	var dir = Directory.new()
	if dir.open(dataDir) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				dir.remove(file_name)
			else:
				dir.remove(file_name)
			file_name = dir.get_next()
	dir.make_dir_recursive(dataDir)
	
func modStart():
	loadMods()
	delGame()
	
func searchPck(dirStr):
	var dir = Directory.new()
	dir.open(dirStr)
	dir.list_dir_begin()
	var dname = dir.get_next()
	while dname != "":
		if dir.current_is_dir() && dname != "core" && dname != "." && dname != "..":
			searchPck(dirStr + "/" + dname)
		elif !dir.current_is_dir() && dname.get_extension() == "pck":
			var modInfo = ModInfo.new()
			modInfo.id = dname.get_basename()
			modInfo.dir = "res://%s" % modInfo.id
			modInfo.file = dirStr+"/"+dname
			modsInfo[dname] = modInfo
		dname = dir.get_next()
	dir.list_dir_end()
	#minLoadMods("res://mods/")
	
func loadMods():
	for i in modsInfo.values():
		ProjectSettings.load_resource_pack(i.file,false) 
		data.loadDir(i.dir)

func newGame(lv):
	for i in get_children():
		if i is Tile :
			i.queue_free()
	delAllDlg()
	var game = preload("res://tscn/game/game.tscn").instance()
	sys.main.add_child(game)
	game.diffLv = lv
	game.mode = "map"
	game.newGame()

func newTowerGame(lv):
	for i in get_children():
		if i is Tile :
			i.queue_free()
	delAllDlg()
	var game = preload("res://tscn/game/game.tscn").instance()
	sys.main.add_child(game)
	game.mode = "tower"
	game.diffLv = lv
	game.mapId = game.getRndDungeonId()
	game.newGame()
