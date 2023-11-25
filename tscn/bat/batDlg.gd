extends BasePopup

onready var itemBox = $ui/pan/items/ScrollContainer/box
onready var hurtDlg 
onready var batScene = $batScene
var csbNumVal = 0

func _ready():
	sys.addTip($"%labCsb","每场战斗，道具可使用次数")
	csbNumVal = 0
	$"%labCsb".text = "%d/%d" % [csbNumVal,sys.player.csbNum]
	batScene.connect("onSetTxt",self,"_setTxt")
	$ui/gbox.init()
	sys.mapScene.pauseBgm(true)
	sys.playBgm("res://res/bgm/c%d.mp3" % sys.rndRan(1,5))
	if sys.game.spd == 0.5 :
		$"%spd1".pressed = true
	elif sys.game.spd == 1.5 :
		$"%spd3".pressed = true
	else :
		$"%spd2".pressed = true
	sys.addTip($"%spd1","X 0.5")
	sys.addTip($"%spd2","X 1")
	sys.addTip($"%spd3","X 2")
	
func _setTxt():
	hurtDlg.setTxt( batScene.txt)

func initTeam(enemyTeam:Team):
	$batScene.initTeam(enemyTeam)
	hurtDlg = sys.newDlg("res://tscn/bat/hurt/hurtDlg.tscn")
	hurtDlg.init(batScene)
	hurtDlg.visible = false
	for i in sys.player.items.items:
		rAddItem(i,-1)
	sys.player.items.connect("onAddItem",self,"rAddItem")
	batScene.connect("onBattleEnd",self,"batEnd")
	hurtDlg.connect("onExit",self,"_on_endBtn_pressed")
	$ui/pan/yinc/btnBat.grab_focus()

func rAddItem(item,inx):
	if item is Csb:
		var itemBt = load("res://tscn/item/itemBtn.tscn").instance()
		itemBox.add_child(itemBt)
		itemBt.init(item)
		itemBt.connect("pressed",self,"_csbUse",[item])
		itemBt.isInfo = false
		
func _csbUse(item):
	if csbNumVal < sys.player.csbNum :
		csbNumVal += 1
		$"%labCsb".text = "%d/%d" % [csbNumVal,sys.player.csbNum]
		item.use()
	else:
		sys.newMsg("超过本场战斗道具使用次数")

func _on_Button2_pressed():
	$ui/pan/yinc/btnBat.hide()
	if batScene.isEnd :
		_on_endBtn_pressed()
	else:
		batScene.battleEnd(false)
func _on_Button3_pressed():
	sys.newDlg("res://tscn/opt/optDlg.tscn")
	pass # Replace with function body.
func _on_Button_pressed():
	hurtDlg.setMode(1)
	hurtDlg.show()

func _on_Button5_pressed():
	var dlg = sys.newDlg("res://tscn/item/itemDlg.tscn")
	dlg.init(sys.player.items)

func _on_btnBat_pressed():
	$ui/pan/yinc/btnBat.hide()
#	for i in masTeam.chas:
#		cellDs[i] = i.cell
	batScene.battleStart()
	sys.playSe("bat.wav")

func _on_endBtn_pressed():
	sys.main.delAllDlg()
	sys.mapScene.emit_signal("onBatSceneDel",batScene.isWin)
	del()
	sys.mapScene.pauseBgm(false)
	
func del():
	queue_free()

func batEnd(isWin):
	hurtDlg.setMode(0)
	hurtDlg.show()
	if isWin :
		sys.playBgm("res://res/bgm/end1.mp3")
	else:
		sys.playBgm("res://res/bgm/end2.mp3")

func _on_batDlg_tree_exiting():
	hurtDlg.queue_free()

func _on_spd1_pressed():
	sys.game.spd = 0.5
	Engine.time_scale = sys.game.spd

func _on_spd2_pressed():
	sys.game.spd = 1.0
	Engine.time_scale = sys.game.spd

func _on_spd3_pressed():
	sys.game.spd = 1.5
	Engine.time_scale = sys.game.spd
