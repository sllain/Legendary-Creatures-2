extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var img = $img

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(faci):
	img.texture = data.newRes(faci.icoId)
	sys.addTip(self,"[center][b]%s[/b]\n%s[/center]" % [tr(faci.name),tr(faci.dec)])
	
