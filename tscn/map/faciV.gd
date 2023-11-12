extends ObjV


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lvLab = $"%lvLab"
var faci:Faci
var rp = RndPool.new([[0,5],[1,1],[2,1],[3,0.3],[4,1],[5,1]])

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(faci):
	self.faci = faci
	if faci.isShowIco == false:
		$"%Ying".hide()
		$"%img".texture_normal = null
		$"%glow".texture = null
		$"%TextureRect".hide()
		$"%name".text = faci.name
	else:
		$"%img".texture_normal = data.newRes(faci.icoId)
		$"%glow".texture = $"%img".texture_normal
		$"%name".hide()
	
	self.faci.connect("onSetGlow",self,"rSetGlow")
	self.faci.connect("onDel",self,"del")
	_setLv()
	self.faci.connect("onSetLv",self,"_setLv")
	.init(faci)
	rSetGlow()
	self.faci.connect("onSetIsCs",self,"_setIsCs")
	_setIsCs()
	if faci.isCs :
		sys.addTip($"%cs","传送标记：点击即可传送到此设施")
	faci.connect("onSetInvalid",self,"_setInvalid")
	_setInvalid()
	
func _setInvalid():
	$"%x".visible = faci.invalid
	
func _setIsCs():
	if self.faci.isCs :
		#$"%AnimationPlayer".play("glow")
		$"%cs".show()
	else:
		#$"%AnimationPlayer".play("RESET")
		$"%cs".hide()
	
func rSetGlow():
	if $"%AnimationPlayer".current_animation == "trig" : return
	if self.faci.glow :
		$"%AnimationPlayer".play("glow")
	else:
		$"%AnimationPlayer".play("RESET")
		
func _setLv():
	$"%lvLab".text = "%d" % faci.lv
	if faci.lv > 8 :return
	if faci.lv > 0 :
		sys.addTip($"%img","[center][color=%s][b]%s[/b][/color]\n%s %d\n %s[/center]" % [cons.colorDs.lvs[faci.lv-1],tr(faci.name),tr("等级："),faci.lv,tr(faci.dec)])
	else:
		sys.addTip($"%img","[center][color=%s][b]%s[/b][/color]\n%s[/center]" % ["#62bf54",tr(faci.name),tr(faci.dec)])
	$"%lvLab".set("custom_colors/font_color",Color(cons.colorDs.lvs[faci.lv-1]))
	$"%lvLab".visible = true if faci.lv > 0 else false

func _on_faciV_pressed():
	faci.emit_signal("onPressed")

func del():
	$"%AnimationPlayer".play("trig")

func trig():
	sys.rogue.dlv += 1
	faci._trig()
	queue_free()

func _on_img_pressed():
	if faci.isCs && sys.mapScene.playFaci.distanceTo(faci) > 1:
		faci.cs()
	elif faci.isPressed :
		faci._pressed()
	else:
		sys.mapScene._cellPressed(faci.cell)
		
func _physics_process(delta):
	._physics_process(delta)
	var v = 1.2 + (sys.mapScene.camera.zoom.x - 1) * 0.3
	scale.x = v;scale.y = v
	var vbl = faci.visible
	if faci.visible : vbl = upSift()
	if vbl :show()
	else:hide()

func upSift():
	if sys.game.isMainMap() == false:return true
	if sys.game.faciSiftInx == 1 && faci is FaciBat:
		return false
	elif sys.game.faciSiftInx == 2 && faci is FaciBat == false:
		return false
	elif faci.id == "faci_bat" :
		return  scale.x < 2
	return true

func _on_faciV_screen_entered():
	set_physics_process(true)
	set_process(true)

func _on_faciV_screen_exited():
	set_physics_process(false)
	set_process(false)

func _on_faciV_visibility_changed():
	if visible :
		_physics_process(0)
