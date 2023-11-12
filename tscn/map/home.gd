extends Control
class_name Home

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var page = 0
onready var time = $time/time
# Called when the node enters the scene tree for the first time.
func init():
	for j in range(sys.player.items.items.size()-1,-1,-1) :
		var i = sys.player.items.items[j]
		if i is Mater && i.isHomeShow:
			var mi = preload("res://tscn/item/itemBtn.tscn").instance()
			$mRect/box.add_child(mi)
			mi.init(i)
	
	sys.addTip($"RtsBar/btnBox/1","部队")
	sys.addTip($"RtsBar/btnBox/4","神徽")
	sys.addTip($"RtsBar/btnBox/2","仓库")
	sys.addTip($"RtsBar/btnBox/3","选项")
	
	if sys.game.globals.has("g_game"):
		sys.addTip($hcBtn,tr("离开")+ "\n" + tr("但是时间会推进 %s") % sys.getTimeStr(sys.game.globals.g_game.hcTime))
	else:
		$hcBtn.hide()
	
	sys.game.connect("onNextTime",self,"rNextTime")
	sys.game.connect("onToMap",self,"_toMap")
	if sys.game.globals.has("g_m"):
		sys.game.globals.g_m.connect("onSetLv",self,"_setMiasmaLv")
		_setMiasmaLv()
	rNextTime()
	if sys.game.isTimeOn == false:
		$time.hide()
 
func _setMiasmaLv():
	var bf = data.newBase("b_a_zhangQi")
	bf.lv = sys.game.globals.g_m.lv
	$time/Node2D/migLab/AnimationPlayer.play("up")
	sys.addTip($"%migLab",tr("瘴气等级：%d \n每过一天提高%d级\n怪物：%s") % [sys.game.globals.g_m.lv,sys.game.globals.g_m.nextMlv,bf.dec])
	$"%migLab".text = "%d" % sys.game.globals.g_m.lv
	$"%migLab".set("custom_colors/font_color",Color(cons.colorDs.lvs[ int( sys.game.globals.g_m.lv/10)]))

func newDlg(file):
	return sys.newDlg(file)

func _on_castle_onPressed():
	var tween = create_tween()
	tween.tween_property($castle,"rect_position",Vector2(-960,0), 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property($take,"rect_position",Vector2(0,0), 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_take_onPressed():
	var tween = create_tween()
	tween.tween_property($castle,"rect_position",Vector2(0,0), 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property($take,"rect_position",Vector2(960,0), 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_1_pressed():
	var dlg = preload("res://tscn/charaDlg/chaManaDlg.tscn").instance()
	add_child(dlg)
	dlg.popup()
	dlg.init(sys.player)

func _on_3_pressed():
	sys.newDlg("res://tscn/opt/optDlg.tscn")

func _on_2_pressed():
	var dlg = newDlg("res://tscn/item/itemDlg.tscn")
	dlg.init(sys.player.items)

func toRouge(layer):
	queue_free()
#	var rogue = preload("res://tscn/rogue/rogue.tscn").instance()
#	sys.game.add_child(rogue)
#	rogue.init(layer)

func rNextTime():
	var tw = create_tween()
	tw.tween_property(time, "rotation_degrees", sys.game.time * 360 / 24.0, 0)
	var txt = tr("第 %d 天") % sys.game.day + " "
	#txt += tr("夜晚") if sys.game.isNight() else tr("白天") + " "
	txt += "\n"
	txt += tr("%d : %d") % [int(sys.game.time),(sys.game.time-int(sys.game.time) ) * 60]  + "\n"
	txt += tr("每过3天会遭遇奇遇") 
	
	sys.addTip($time/k,"[center]%s[/center]" % txt)

func _on_home_tree_entered():
	pass

func _on_4_pressed():
	var dlg = newDlg("res://tscn/bat/relic/relicDlg.tscn")
	dlg.init(sys.player.relics.items)
	pass # Replace with function body.

func _toMap(mapId):
	if sys.game.mode == "map":
		$hcBtn.visible = mapId != sys.game.mainMapId
	else:
		$hcBtn.hide()

func _on_hcBtn_pressed():
	sys.game.hc()
	
