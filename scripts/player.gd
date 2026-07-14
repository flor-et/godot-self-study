extends CharacterBody2D

var speed = 63;
var last_direction = Vector2(1,0);

# handle player movement
func _physics_process(delta):
	# get movement input
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	# toggle running
	if(Input.is_action_pressed("run")):
		velocity *= 2
		$AnimatedSprite2D.speed_scale = 2
	else:
		$AnimatedSprite2D.speed_scale = 1
		
	# move player
	move_and_slide()	# move_and_collide(direction)
	
	# set proper player sprite
	if (direction.length() > 0):
		last_direction = direction # store last direction for proper idle sprite
		play_walk_animation(direction)
	else:
		play_idle_animation(last_direction)
		
func play_walk_animation(direction):
	if(direction.y > 0):
		$AnimatedSprite2D.play("walk_down")
		return
	if(direction.y < 0):
		$AnimatedSprite2D.play("walk_up")
		return
	if(direction.x > 0):
		$AnimatedSprite2D.play("walk_right")
	if(direction.x < 0):
		$AnimatedSprite2D.play("walk_left")
		
func play_idle_animation(direction):
	if(direction.x > 0):
		$AnimatedSprite2D.play("idle_right")
	if(direction.x < 0):
		$AnimatedSprite2D.play("idle_left")
	if(direction.y > 0):
		$AnimatedSprite2D.play("idle_down")
	if(direction.y < 0):
		$AnimatedSprite2D.play("idle_up")
		
		
