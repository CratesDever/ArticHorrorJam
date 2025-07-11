extends Area3D
var speed = 8

func _ready() -> void:
	await get_tree().create_timer(4).timeout
	queue_free()

func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * -speed * delta)
