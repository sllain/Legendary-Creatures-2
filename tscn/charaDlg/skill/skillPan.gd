extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lvBtn = $lvBtn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var skill
var cha
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(skill,cha):
	self.skill = skill
	self.cha = cha
	$skillBtn.init(skill)
	skill.connect("onSetLv",self,"upStr")
	cha.connect("onSetLv",self,"r")
	cha.connect("onSetSp",self,"r")
	r()
	upStr()
	
func upStr():
	var txt = skill.getDec()
	for i in cons.tipDs:
		txt = txt.replace("%s" % tr(i),"[color=#ffff55][url={id}]{ids}[/url][/color]".format({id=i,ids=tr(i)}))
	$box/txt.bbcode_text = txt
	$box/name.text = tr("%s：%d级") % [tr(skill.name),skill.lv]
	$box/lv.text = "%s" % skill.trTab()
	if skill.cd > 0 :
		$box/cd.text = tr("CD: %d %s") % [skill.cd,tr("秒")]
	else:
		$box/cd.text = tr("被动")
	var k2 = data.newBase(skill.id)
	k2.lv = skill.lv + 1
	sys.addTip(lvBtn,"%s\n%s" % [tr("升级后 等级:%d") % k2.lv,k2.dec])
	
func r():
	if skill.lv >= skill.maxLv || skill.lv >= cha.lv ||cha.team != sys.player.team || cha.sp <= 0:
		$lvBtn.hide()
	else:
		$lvBtn.show()
	

func _on_lvBtn_pressed():
	if skill.lv < skill.maxLv :
		skill.lv += 1
		cha.sp -= 1
	else:
		sys.newMsg("已经最高等级")
#	pass # Replace with function body.

func _on_txt_meta_clicked(meta):
	sys.newMsg("%s:%s" % [tr(meta),tr(cons.tipDs[meta])])
