extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var txt = $txt

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(isWin):
	sys.main.initSaveDir()
	if isWin :
		if sys.game.mode == "map" :
			txt.text =  tr("在第%d天 通关了 难度%d") % [sys.game.day,sys.game.diffLv] + "\n" 
			if sys.game.globals.g_shenQi.on :
				 txt.append_bbcode(tr("击败了浩劫下的魔王") + "\n")
			if sys.game.diffLv >= sys.lockDiffLv :
				sys.lockDiffLv = sys.game.diffLv + 1
		else:
			txt.text =  tr("爬塔模式 通关了 难度%d") % [sys.game.diffLv] + "\n" 
			if sys.game.diffLv >= sys.lockDiffLvTower :
				sys.lockDiffLvTower = sys.game.diffLv + 1
		
		$bg.texture = load("res://res/Gui/Victory_window.png")
		
		sys.saveInfo()
		if sys.godotSteam != null:
			sys.godotSteam.ach("00%d" % sys.game.diffLv)
	else:
		txt.text = tr("失败") + "\n"
	
	var item = sys.player.items.hasIdItem("m_cry")
	if item != null:
		data.cry = item.num
		data.saveLock()
	txt.append_bbcode(tr("收集了 %d 晶石") % sys.game.plusCryNum + "\n")
	for i in sys.game.achs.items:
		if i.isAchCom :
			txt.append_bbcode(tr("解锁 %s:%s") % [tr(i.name),tr(i.achDec)] + "\n")

func _on_Button_pressed():
	del()

func del():
	.del()
	sys.main.endGame()
	
