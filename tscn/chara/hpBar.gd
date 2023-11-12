extends Node2D
#血条组件
#依赖：battle，需要ui层
var mas:Chara = null
onready var valSpr = $hp/val
onready var valSpr2 = $hp/val2
onready var ward = $hp/val3
var wardPos
var offset = Vector2(0,0)
var maxW = 0
var maxVal = 0
onready var timer = $Timer

func _ready():
	pass
	wardPos = ward.position
	
func init(unit:Chara,upY = true):
	for i in get_incoming_connections ():
		i["source"].disconnect(i["signal_name"],self,i["method_name"])		
	mas = unit
	offset = position
	maxW = valSpr.region_rect.size.x
	mas.connect("onHurt",self,"runHurt")
	runChangeTeam()
	mas.connect("onChangeTeam",self,"runChangeTeam")
	mas.connect("onPlus",self,"rPlus")
	up()
	valSpr2.region_rect.size.x = valSpr.region_rect.size.x
	
func rPlus(info):
	up()
	
func pause(bl = true):
	if bl :
		set_process(false)
		valSpr2.modulate = Color("ffffff")
	else:
		set_process(true)
		valSpr2.modulate = Color("e40000")

func _process(delta):
	if valSpr.region_rect.size.x < valSpr2.region_rect.size.x :
		valSpr2.region_rect.size.x -= 10*delta
		
func up():
	maxVal = mas.maxHp + mas.ward
	valSpr.region_rect.size.x = float(mas.hp)/mas.maxHp * maxW
	ward.region_rect.size.x = float(clamp(mas.ward,0,maxVal))/maxVal * maxW
	ward.position.x = wardPos.x + clamp(valSpr.region_rect.size.x,0,maxW - ward.region_rect.size.x)
	
func runHurt(atkInfo):
	up()
	pause(true)
	timer.start(0.1 * atkInfo.val / atkInfo.castCha.atk)
	yield(timer,"timeout")
	pause(false)
	
func runChangeTeam():
	if mas.team == null:return
	if mas.team == sys.player.team  :
		valSpr.modulate = Color("6bdf65")
	else:
		valSpr.modulate = Color("ec5959")
