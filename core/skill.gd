extends Buff
class_name Skill
signal onCast()

var cd = 0
var cdVal = 0
var ranDec = ""

var lvUps = {} #升级所需材料

func _init():
	._init()
	lvPerVal = 0.20
 
var castNum = 0
func castStart():
	if _castIf() && castNum < 10:
		_cast()
		masCha.skillTime = masCha.skillTimeS / masCha.cdSpd
		cdVal = 0
		emit_signal("onCast")
		masCha.emit_signal("onCastSkill",self)
		sys.game.emit_signal("onChaCastSkill",self)
		castNum += 1
		return true
	return false

func _cast():
	pass
	
func _castIf():
	if masCha.skillTime <= 0 && cdVal >= cd && cd != 0:
		return true
	return false
	
func _selIf(cha):
	return true

func _process(delta):
	._process(delta)
	if cd != 0 && masCha.yunTime <= 0:
		cdVal += mas.cdSpd * delta
	castNum = 0	
