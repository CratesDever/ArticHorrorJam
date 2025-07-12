class_name Enemy

extends CharacterBody3D
@export var navAgent : NavigationAgent3D
@export var speed : float = 4
@export var player : Node3D
@export var health : int = 5
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
func _physics_process(delta: float) -> void:
	navAgent.target_position = player.global_position
	if navAgent.distance_to_target() > 0.1:
		var point = navAgent.get_next_path_position()
		velocity = (point - global_position).normalized() * speed
		move_and_slide()
		
func TakeDamage(dmg):
	health -= dmg
	if health <= 0:
		queue_free()
		
