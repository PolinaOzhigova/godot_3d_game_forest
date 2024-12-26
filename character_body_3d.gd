extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 2.0
const GRAVITY = 0.98

@onready var anim = $CollisionShape3D/Sketchfab_Scene/AnimationPlayer

func _ready() -> void:
	anim.get_animation("Scene")
	
	anim.play("Scene")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY - GRAVITY

	# Handle rotation (left/right input for turning).
	if Input.is_action_pressed("left"):
		rotation.y += ROTATION_SPEED * delta
	elif Input.is_action_pressed("right"):
		rotation.y -= ROTATION_SPEED * delta

	# Get the input direction and handle the movement/deceleration.
	# Use forward and backward for movement.
	var input_dir := Input.get_vector("", "", "forward", "backward") # Только ui_up и ui_down
	var direction := (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
