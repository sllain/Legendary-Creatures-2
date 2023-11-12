extends Control
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t:LocaCastle.Tecl

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func init(t):
	self.t = t
	$name.text = t.name
	r()
	t.connect("onSetLv",self,"r")
	sys.addTip($info,t.getLvDec(t.lv))
	sys.addTip($upBtn,t.getLvDec(t.lv + 1))
	
func r():
	$lv.text = "%d级" % t.lv
	if t.lv >= t.maxLv :
		$upBtn.hide()
	sys.addTip($info,t.getLvDec(t.lv))

func _on_upBtn_pressed():
	if t.lv < t.maxLv :
		sys.newDlg("res://tscn/base/upLvDlg.tscn").init(t)
	else:
		sys.newMsg("已经最高等级")

