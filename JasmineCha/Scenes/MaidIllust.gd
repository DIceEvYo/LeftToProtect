extends Sprite2D

var radius = 10             
var speed = 1             
var center_position = Vector2()

#Parameters for floating (up and down)
var float_amplitude = 10       #How high/low the character floats
var float_speed = 1.5       #Speed of floating motion

#Internal variables
var angle = 0.0                #Current angle for circular motion
var time = 0.0                 #Time counter for floating

func _ready():
	center_position = position  #Set the starting position as the center of the circular motion

func _process(delta):
	#Circular motion
	angle += speed * delta  #Increment the angle over time
	var offset_x = radius * cos(angle)
	var offset_y = radius * sin(angle)

	#Floating motion (up and down)
	time += float_speed * delta
	var float_offset = float_amplitude * sin(time)

	#Combine circular motion and floating motion
	position = center_position + Vector2(offset_x, offset_y + float_offset)
