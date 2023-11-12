extends AnimatedSprite


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
func init(cha):
	self.cha = cha
	cha.connect("onSetDire",self,"rSetDire")
	upAnim()
	cha.connect("onUpAnim",self,"upAnim")
		
func upAnim():
	flip_h = cha.animFlip
	cha.imgCenterPos = Vector2(0,position.y)
	frames = load(cha.animFile) 
	offset = cha.animOffset
	#cha.imgCenterPos = Vector2(0,position.y)
	cha.imgCenterPos = Vector2(0,-30)
	rSetDire()
	if cha.isBoss :
		use_parent_material = false
	else:
		use_parent_material = true

func rSetDire():
	scale = cha.animScale
	if cha.dire == -1 :
		scale.x = -scale.x
	if cha.isBoss:
		scale *= 1.5
	position.y = - frames.get_frame("idle",0).get_height() * scale.y * 0.5  + 5


func _on_anim_animation_finished():
	if animation == "move" :play("move")
	else:play("idle")
