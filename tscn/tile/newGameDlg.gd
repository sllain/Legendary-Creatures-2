extends BaseDlg
signal onSelDiff(lv)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lv = 0
var llv = 0
var ds = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	ds = preload("res://ex/global/g_diff.gd").new().lvDec
	if sys.isDemo :
		llv = 0
	else:
		llv = clamp(sys.lockDiffLv,0,ds.size() -1)
	lv =  llv
	up()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func r(lv):
	emit_signal("onSelDiff",lv)
	del()
	sys.main.newGame(lv)

func _on_2_pressed():
	if sys.isDemo :
		sys.newMsg("试玩版只有难度0")
		return
	lv += 1
	
	if lv > ds.size() -1:
		lv = ds.size()-1
		sys.newMsg("目前最高")
	elif lv > llv :
		lv = llv
		sys.newMsg("你需要通关当前等级，才可解锁下一个等级")
	up()

func _on_1_pressed():
	lv -= 1
	if lv < 0 :
		lv = 0
	up()
	
func up():
	$diffi/lvLab.text = "%d" % lv
	$"%txt".bbcode_text = "[center]%s[/center]" % tr(ds[lv])

func _on_Button_pressed():
	r(lv)
