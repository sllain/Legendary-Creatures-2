extends "res://tscn/eventDlg/eventBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var basePer
var per
var lv = 0
var stup
var maxNum
var num = 0
var subVal
var mId = "m_key"
var m 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(per,mId = "",stup = 0.1,subVal = 3,tab = "",maxNum = 3):
	self.basePer = per
	self.per = basePer
	self.stup = stup
	self.maxNum = maxNum
	self.subVal = subVal
	self.mId = mId
	if mId != "" :
		m = data.newBase(mId)
		$Button.ico = data.newRes(m.icoId)
	else:
		$Button.hide()
	up()

func _on_Button3_pressed():
	if sys.rndPer(per) :
		$perLab.text = "成功！"
		emit_signal("onSel",true)
	else:
		$perLab.text = "失败"
		emit_signal("onSel",false)
		
	$Button.hide()
	$Button3.hide()

func _on_Button_pressed():
	if sys.player.subItem(mId,subVal) :
		lv += 1
		per = basePer * (1 + lv * stup)
		num += 1
		if num >= maxNum :
			$Button.hide()
		up()
	else:
		sys.newMsg(tr("%d 不足" % tr(m.name)))

func up():
	$Button/Label2.text = "%d/%d" % [num,maxNum]
	$perLab.text = tr("成功率 %d%%") % [per * 100]
	$Button.text = "%d" % subVal

