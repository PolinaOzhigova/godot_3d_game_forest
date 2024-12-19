extends Node3D

@onready var anim = $AnimationPlayer
func _ready() -> void:
	anim.get_animation("Take 001")
	anim.play("Take 001")

func _process(delta: float) -> void:
	pass
