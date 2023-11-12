extends Node2D
class_name Eff

signal onReach()
signal onInchara(chara)
signal onAnimTrig()

func data():
	pass

func loadInfo(dname,dir):
	self.id = dname
	self.dir = dir

var posMove = Vector2()
onready var up = $up
var anim = null
var flyMode = 0  #0:不飞行     1:目标单位   2：目标位置
var flyChara = null
var flySpd = 200
var flyPos =Vector2()
var isLookAt = true
var scene 

func _ready():
	set_process(false)
	set_physics_process(false)
	scene = get_node("../../")
	
func _process(delta):
	position += posMove * delta
			
func _physics_process(delta):
	var tPos = Vector2()
	if flyMode == 2 :
		tPos = flyPos
		if isLookAt: sprLookAt(tPos+scene.rect_position)
	elif flyMode == 1 && flyChara != null:
		tPos = flyChara.position
		if isLookAt: sprLookAt(flyChara.position+scene.rect_position)
	if flyMode != 0 :
		var lpos = tPos - position
		posMove = lpos.normalized() * flySpd
		#normalSpr.rotation = position.angle_to_point(posMove)
		if lpos.length() <= flySpd * delta:
			emit_signal("onReach")
			del()
			
func flyToChara(chara,flySpd = 300):
	flyChara = chara
	flyMode = 1
	self.flySpd = flySpd
	set_process(true)
	set_physics_process(true)

func flyToPos(pos,flySpd = 300):
	flyPos = pos
	flyMode = 2
	self.flySpd = flySpd
	set_process(true)
	set_physics_process(true)
	
func flyToPosEx(pos,leng,flySpd = 300):
	flyToPos(position.direction_to(pos) * leng,flySpd) 
	
func setNorPos(pos):
	if up!= null: up.position = pos
	
func play(name):
	anim.play(name)
	
func move(x=0,y=0):
	posMove.x = x
	posMove.y = y
	set_physics_process(true)

func speed(s):
	posMove = posMove.normalized() * s

func del():
	_del()
	queue_free()
func animation_finished(anim_name):
	anim_name = ""
	del()
	
func _del():
	pass

func sprLookAt(pos):
	up.look_at(pos + up.position)
	
func sceneLookAt(pos):
	up.look_at(pos + scene.rect_position + up.position)
	
func inChara(chara):
	_inChara(chara)
	emit_signal("onInchara",chara)
		
func _inChara(chara):
	pass

func animTrig():
	emit_signal("onAnimTrig")
