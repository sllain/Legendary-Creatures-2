extends BaseDlg

signal onSel(cha)

func init(team):
	for i in team.chas:
		var bt = preload("res://tscn/chara/selChaItem.tscn").instance()
		bt.init(i)
		bt.get_node("Button").connect("pressed",self,"_pressed",[bt])
		$ScrollContainer/GridContainer.add_child(bt)
		
func _pressed(bt):
	emit_signal("onSel",bt.cha)
	del()
