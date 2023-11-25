extends Control

class_name Tile
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var loadMode = "map"

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.open(sys.main.dataDir + "/game.data",File.READ) == OK:
		var ds = file.get_var()
		file.close()
		if ds.has("mode") : loadMode = ds.mode
		$NinePatchRect2/VBoxContainer/Button4.show()
	else:
		$NinePatchRect2/VBoxContainer/Button4.hide()

	sys.playBgm("res://res/bgm/tile.mp3",3.5)
	if sys.isDemo :
		$demo.text = tr("试玩版") + " 0.3"
		$TextureRect.texture = load("res://tscn/tile/bg/Castle.png")
	else:
		$demo.text = "1.1"
	
	$OptionButton.select(lgDs[sys.lg])

	if sys.quDao == "gwp" :
		$demo.visible = true
		$demo.text = "仅供GWP试玩"
	
func _on_Button_pressed():
	if sys.isBeta:
		var dlg = sys.newDlg("res://tscn/tile/selModeDlg.tscn")
	else:
		var dlg = sys.newDlg("res://tscn/tile/newGameDlg.tscn")
	pass # Replace with function body.

func _on_Button3_pressed():
	get_tree().quit()

func _on_Button2_pressed():
	sys.newDlg("res://tscn/tile/sheZhi.tscn")

func _on_Button4_pressed():
	queue_free()
	var game = load("res://tscn/game/game.tscn").instance()
	game.mode = loadMode
	sys.main.add_child(game)
	game.loadGame()

func _on_book_pressed():
	if sys.isDemo && sys.isTest == false:
		sys.newMsg("试玩版未解锁此功能")
		return
	sys.newDlg("res://tscn/book/bookDlg.tscn")
	pass # Replace with function body.

func _input(event):
	if sys.isMod && event.is_action_pressed("mod") :
		sys.isTest = true
		$modBtn.show()
	pass

var lgDs = {
	"zh_CN":0,
	"en":1,
	"zh_HK":2,
	"ja":3
}

func _on_OptionButton_item_selected(id):
	if id == 0 :
		sys.lg = "zh_CN"
	elif id == 1 :
		sys.lg = "en"
	elif id == 2 :
		sys.lg = "zh_HK"
	elif id == 3 :
		sys.lg = "ja"

func _on_tile_tree_exiting():
	sys.saveInfo()

func _on_modBtn_pressed():
	sys.newDlg("res://tscn/mod/modToolDlg.tscn")
