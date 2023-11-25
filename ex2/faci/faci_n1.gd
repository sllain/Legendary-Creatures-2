extends Faci

func _data():
	name = "战争学院"
	dec = "使你一个角色掌握一个其他职业的技能"
	weight = 1
	tab = "world"
	num = 1
	lockType = 1
	lock = 0
	achDec = "通关难度1"
	num = nums.size()

const nums = [2,4]
	
func _createStart():
	createLv = nums[0]
	nums.remove(0)
	
var skills = ItemPck.new()

func _in():
	lv = 0

func _initInfo():
	skills.clear()
	for i in 4 :
		skills.addItem(data.newBase(rnp.skillPool.rndItem(self,"upSKillsRnf").id))
	return skills
		
func upSKillsRnf(skill):
	if skill.hasTab("专属") :return false
	for i in skills.items:
		if i.id == skill.id :
			return false
	return true

func _trig():
	sys.eventDlg.txt("%s" % [dec],true)
	var kdlg = sys.eventDlg.selSkill(skills)
	kdlg.reUpBtn.link(20,self,"_initInfo")
	var skill = yield(kdlg,"onSel")
	if skill == null:return
	var dlg = sys.newDlg("res://tscn/chara/selChaDlg.tscn")
	dlg.init(sys.player.team)
	var cha :Chara= yield(dlg,"onSel")
	if cha == null:return
	if cha.exSkills.items.size() > 0 :
		sys.eventDlg.txt("已经学过别的技能")
		return	
	if cha.hasOrTab(skill.tab) :
		sys.eventDlg.txt("无法学习自身职业的技能")
		return
	del()
	cha.skills.addItem(skill)
	cha.exSkills.addItem(skill)
	sys.eventDlg.txt("%s %s %s" % [tr(cha.name),tr("学会了"),tr(skill.name)])
		
func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 1 :
		achCom()

func getSave():
	var ds = {
		skills = skills.getSave(),
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	skills = ItemPck.new().setSave(ds.skills)
