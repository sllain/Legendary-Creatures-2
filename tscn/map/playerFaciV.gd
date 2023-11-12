extends "res://tscn/map/faciV.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lig = $Light2D

# Called when the node enters the scene tree for the first time.
func init(faci):
	.init(faci)
	lig.hide()
	if sys.game.isTimeOn :
		sys.game.connect("onNextTime",self,"rNextTime")
		rNextTime()
	sys.player.connect("upChas",self,"upLv")
	upLv()
	faci.connect("onSetCell",self,"_setCell")
	faci.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _setCell():
	if sys.mapScene.map.get_cellv(faci.cell) in [338,341] :
		$"%img".texture_normal = preload("res://res/Colored/68_ship.png")
	else:
		$"%img".texture_normal = preload("res://res/Colored/27_players.png")
	$"%glow".texture = $"%img".texture_normal
	
func rNextTime():
	if (sys.game.time >= 18 || sys.game.time <= 6 ) && sys.isLight: 
		lig.show()
	else :
		lig.hide()

func upLv():
	var lv = sys.player.lv
	lvLab.text = str(lv)
	sys.addTip($"%img","[center][color=%s][b]%s[/b][/color]\n%s %d\n%s %d\n %s[/center]" % [cons.colorDs.lvs[lv-1],tr(faci.name),tr("人口："),sys.player.maxPopl,tr("战力等级："),lv,faci.dec])
	lvLab.set("custom_colors/font_color",Color(cons.colorDs.lvs[lv-1]))

func upSift():
	return true
