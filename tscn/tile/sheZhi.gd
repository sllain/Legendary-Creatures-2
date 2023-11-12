extends BaseDlg

var v = Vector2(16,8)
var fbs = [v * 80,v * 100,v * 120,v * 150,v * 180,v * 200]

func _ready():
	$HSlider.value = sys.bgmVol * 100
	$HSlider2.value = sys.seVol * 100
	
	for i in range(fbs.size()):
		$fenBian.add_item(str(fbs[i]),i)
		
	$fenBian.text = str(OS.window_size)
	$fenBian/CheckButton.pressed = OS.window_fullscreen
	$fenBian.select(-1)
	$fenBian.text = str(OS.window_size)
	$CheckL.pressed = sys.isLight
	
func init():
	popup()

func _on_HSlider_value_changed(value):
	sys.bgmVol = value / 100
	
func _on_HSlider2_value_changed(value):
	sys.seVol = value / 100

func _on_Control_tree_exiting():
	pass

func _on_Button_pressed():
	sys.newMsg("zhiZuoMsg").init()
	pass # Replace with function body.

func _on_CheckButton_pressed():
	OS.window_fullscreen = $fenBian/CheckButton.pressed
	pass # Replace with function body.

func _on_LinkButton_pressed():
	sys.newDlg("res://tscn/tile/zuoZhe.tscn")
	pass # Replace with function body.

func _on_CheckButton2_pressed():
	sys.spdOn = $spdBtn.pressed

func _on_baseDlg_tree_exiting():
	sys.saveInfo()

func _on_fenBian_item_selected(index):
	OS.window_size = fbs[index]
	OS.center_window()

func _on_CheckL_pressed():
	sys.isLight = $CheckL.pressed

