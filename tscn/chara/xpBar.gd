extends Node2D

onready var valSpr = $hp/val
onready var valSpr2 = $hp/val2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cha :Chara
var maxW
var aval = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(cha:Chara):
	self.cha = cha
	maxW = valSpr.region_rect.size.x
	cha.connect("onPlusXp",self,"up")
	cha.connect("onPlusLv",self,"d")
	d()
		
func up(val):
	self.aval += val
	if aval != 0 :
		$Label.text = "+%d" % aval
		$Label.show()
	else:
		$Label.hide()
	valSpr2.region_rect.size.x = clamp(float(cha.xp)/cha.maxXp * maxW,0,maxW)
	if cha.xp >= cha.maxXp :
		valSpr.region_rect.size.x = maxW
		valSpr2.region_rect.size.x = 0
		$hp/AnimationPlayer.play("l")
	else:
		$hp/AnimationPlayer.play("n")

func d():
	valSpr.region_rect.size.x = clamp(float(cha.xp)/cha.maxXp * maxW,0,maxW) 
	$Label.hide()
	valSpr2.region_rect.size.x = 0
	if cha.xp >= cha.maxXp :
		$hp/AnimationPlayer.play("l")
	else:
		$hp/AnimationPlayer.play("n")
