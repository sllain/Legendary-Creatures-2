extends BaseDlg

func _on_baseDlg_onDel():
	data.saveLock()

func _ready():
	data.connect("onSetCry",self,"_setCry")
	_setCry()
	sys.addTip($Button,"禁用本页可解锁的内容，使他们不会出现在游戏里") 
	
func _setCry():
	$NinePatchRect/Label.text = "%d" % data.cry
	sys.addTip($NinePatchRect/TextureRect,"解锁部分内容所消耗的晶石")

func _on_Button_pressed():
	sys.newMsg("已禁用本页解锁的内容")
	$TabContainer.get_current_tab_control().SetAllDisable(true)
