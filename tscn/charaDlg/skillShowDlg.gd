extends BaseDlg

func init(skills):
	for i in skills.items :
		var bt = load("res://tscn/charaDlg/skill/skillBtn.tscn").instance()
		$"%box".add_child(bt)
		bt.init(i)
		bt.initTip()
