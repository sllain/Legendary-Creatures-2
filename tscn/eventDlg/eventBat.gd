extends "res://tscn/eventDlg/eventBase.gd"

signal onBattleEnd(isWin)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var team = null
var faci 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(team:Team,canExit = true,faci = null):
	for i in team.chas:
		var c = load("res://tscn/chara/charaItem.tscn").instance()
		$ScrollContainer/HBoxContainer.add_child(c)
		c.init(i)
	self.team = team
	self.faci = faci
	if canExit == false:
		$"%Button2".hide()

func _on_Button_pressed():
	var bl = false
	for i in sys.player.team.chas:
		if i.cell.x < 5 :
			bl = true
			break
	if bl :
		
		sys.mapScene.battle(team)
		sys.batScene.faci = faci
		$"%Button".hide()
		sys.eventDlg.clrar()
		emit_signal("onSel",1)
	else:
		sys.newMsg("没有安排出战单位，请在部队中安排")

func _on_Button2_pressed():
	sys.eventDlg.clrar()
	emit_signal("onSel",0)

func _on_eventBase_visibility_changed():
	if visible :
		$"%Button".grab_focus()

