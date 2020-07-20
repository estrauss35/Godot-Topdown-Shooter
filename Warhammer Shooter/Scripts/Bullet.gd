extends RigidBody2D

var explosion = preload("res://Prefabs/Projectiles/Explosion.tscn")

func _on_Bullet_body_entered(body):
	if not body.is_in_group("player"):
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
