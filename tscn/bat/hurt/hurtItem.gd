extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var al = $a
onready var dl = $d
onready var hl = $h
onready var bl = $b

var a = 0.0
var d = 0.0
var h = 0.0
var w = 0.0
var b1 = 0
var b2 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(cha:Chara):
	cha.connect("onCastHurt",self,"rHurt")
	cha.connect("onHurt",self,"r2")
	cha.connect("onCastPlus",self,"rPlus")
	cha.connect("onCastBuff",self,"rBuff")
	$name.text = cha.name
	$name.set("custom_colors/font_color",Color(cons.colorDs.lvs[cha.lv-1]))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func rHurt(atkInfo):
	a += atkInfo.finalVal
	
func r2(atkInfo):
	d += atkInfo.finalVal
	
func rPlus(info):
	if info.type == "hp" :
		h += info.finalVal
	elif info.type == "ward" :
		w += info.finalVal
		
func rBuff(buff:Buff):
	if buff.hasTab("buff") :
		b1 += buff.plusLv
	else:
		b2 += buff.plusLv

func up():
	al.text = "%d" % a
	dl.text = "%d" % d
	hl.text = "%d/%d" % [h,w]
	bl.text = "%d/%d" % [b1,b2]
