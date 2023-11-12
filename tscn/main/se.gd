extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(file):
	stream = load(file)
	#stream.loop = false
	play()
	
func initMp3(file):
	var f  = File.new()
	if f.open(file,File.READ) ==  OK :
		var stream = AudioStreamMP3.new()
		stream.data = f.get_buffer(f.get_len())
		self.stream = stream
		self.stream.loop = false
		play()
		f.close()

func _on_se_finished():
	queue_free()
