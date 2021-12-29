extends Area2D

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of game window

signal hit

func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled=false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x-=1
	if Input.is_action_pressed("move_right"):
		velocity.x+=1
	if Input.is_action_pressed("move_up"):
		velocity.y-=1
	if Input.is_action_pressed("move_down"):
		velocity.y+=1
	
	if velocity.length()>0:
		velocity = velocity.normalized() * speed
		if velocity.x != 0:
			$AnimatedSprite.animation="walk"
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = velocity.x < 0
		elif velocity.y != 0:
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.flip_v = velocity.y > 0

		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity*delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)


func _on_Player_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

