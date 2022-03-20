extends KinematicBody2D

const GRAVITY = 200.0
const WALK_SPEED = 200
const SPRINT_SPEED = 400
const ACCEL_SPEED = 10
const JUMP_SPEED = 90
var CURRENT_MAX_SPEED = WALK_SPEED
var CURRENT_SPEED = 0

var velocity = Vector2()
var air_pressure = 100

func _ready():
	pass

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	# SPRINT DETECTION
	if Input.is_action_pressed("sprint"):
		CURRENT_MAX_SPEED = SPRINT_SPEED
	else:
		CURRENT_MAX_SPEED = WALK_SPEED
	
	# SPRITE CONTROL
	if Input.is_action_just_pressed("player_left"):
		$SpriteLayer/Wheels.play()
		for _i in $SpriteLayer.get_children():
			_i.flip_h = true
	if Input.is_action_just_pressed("player_right"):
		$SpriteLayer/Wheels.play()
		for _i in $SpriteLayer.get_children():
			_i.flip_h = false
	
	# MOVEMENT
	if Input.is_action_pressed("player_left"):
		if CURRENT_SPEED < CURRENT_MAX_SPEED:
			CURRENT_SPEED += ACCEL_SPEED
		velocity.x = -CURRENT_SPEED
	elif Input.is_action_pressed("player_right"):
		if CURRENT_SPEED < CURRENT_MAX_SPEED:
			CURRENT_SPEED += ACCEL_SPEED
		velocity.x = CURRENT_SPEED
	else:
		$SpriteLayer/Wheels.stop()
		CURRENT_SPEED = 0
		velocity.x = CURRENT_SPEED
		
	
	# "JUMPING"
	if Input.is_action_pressed("player_up"):
		velocity.y = -JUMP_SPEED
	move_and_slide(velocity, Vector2(0,-1))
