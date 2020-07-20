extends KinematicBody2D

export (int) var speed = 200
export (int) var bullet_speed = 1000
export (float) var fire_rate = 0.2

var velocity = Vector2()
var mouse_pos
var bullet = preload("res://Prefabs/Projectiles/Bullet.tscn")
var can_fire = true

func get_input():
	velocity = Vector2()
	if(Input.is_action_pressed("down")):
		velocity.y += 1
	if(Input.is_action_pressed("up")):
		velocity.y -= 1
	if(Input.is_action_pressed("left")):
		velocity.x -= 1
	if(Input.is_action_pressed("right")):
		velocity.x += 1
	velocity = velocity.normalized() * speed
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func _process(delta):
	look_at_mouse()
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()
	
func look_at_mouse():
	mouse_pos = get_local_mouse_position()
	rotation += mouse_pos.angle()
	
func shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $BulletPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
