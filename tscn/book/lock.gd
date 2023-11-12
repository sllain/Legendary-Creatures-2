extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var item
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(item):
	self.item = item
	if item.lockType == 0 :
		sys.addTip($"box/1",tr("解锁:花费%d晶石") % item.lockVal)
	else:
		sys.addTip($"box/1",tr("解锁:%s") % tr(item.achDec))
		$"box/1".self_modulate = Color.aliceblue
	sys.addTip($"box/2",tr("是否出现在游戏里"))
	up()
	
func _on_1_pressed():
	if item.lockType != 0 :return
	if yield( sys.newMsg(tr("花费 %d 晶石 解锁该项目？") % item.lockVal,true) ,"onSel") :
		if data.ulock(item) == false:
			sys.newMsg(tr("晶石 不足"))
	up()

func _on_2_pressed():
	data.setDisable(item,!$"box/2".pressed)
	up()

func up():
	if data.lockDs.has(item.id) :
		$"box/1".hide()
		$"box/2".show()
		$"box/2".pressed = !data.disableDs.has(item.id) 
	else:
		$"box/2".hide()
		$"box/1".show()

func setDisable(bl):
	if $"box/2".visible == false:return
	data.setDisable(item,bl)
	up()
