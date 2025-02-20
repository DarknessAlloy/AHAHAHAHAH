extends CharacterBody2D


@export var Player_Speed = 250
@export var SPEED = 300.0
@export var acceleration_start = 0.1
@export var acceleration_max = 1.5
var acceleration = 0
var Diag_Damp = 0.75 ## This slows down the player from accelerating stupidly when going Y or X.


func Calc_Velocity() -> String:
	if velocity.x == 0 and velocity.y == 0 and acceleration > acceleration_start: 
		acceleration = acceleration_start
	
	velocity.x = Input.get_axis("ui_left", "ui_right") * (Player_Speed * acceleration)
	velocity.y = Input.get_axis("ui_down", "ui_up") * -1 * (Player_Speed * acceleration)
	if (abs(velocity.x) == abs(velocity.y)):
		velocity.x *= Diag_Damp
		velocity.y *= Diag_Damp
	if acceleration < acceleration_max:
		acceleration += 0.1
	move_and_slide()
	
	
	return "Pass"
#pass
func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration+.
	# As good practice, you should replace UI actions with custom gameplay actions.
	Calc_Velocity()
