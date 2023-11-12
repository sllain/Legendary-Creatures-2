extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cha
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(cha:Chara):
	self.cha = cha
	cha.connect("onSetLv",self,"up",[null])
	up(null)
	sys.addTip($lvLab,"[center][b]%s[/b][/center]" % tr("等级"))
	if cha.team == null :return
	if cha.team != sys.player.team : return
	var item = sys.player.items.hasIdItem("m_xp")
	if item != null:
		item.connect("onSetNum",self,"up",[null])
	sys.game.connect("onChaPlusLv",self,"up")
	
	#sys.addTip($popLab,"[center][b]人口[/b][/center]")

func upl(a,b):
	up(null)

func up(c):
	$lvLab.text = "%d" % cha.lv
	if cha.team == null :return
	#$popLab.text = "%d" % cha.pop
	if cha.team == sys.player.team && cha.isSummon == false && cha.lv < cha.maxLv && cha.maxXp <= sys.player.items.hasIdItem("m_xp").num :
		$AnimationPlayer.play("l")
	else:
		$AnimationPlayer.play("a")
