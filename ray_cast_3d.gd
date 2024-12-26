extends RayCast3D

@onready var interact_promt_label = get_node("Label")

func _process(delta: float) -> void:
	var object = get_collider()
	interact_promt_label.text = ""
	
	if object and object is Interact:
		if object.can_interact == false:
			return
			
		interact_promt_label.text = "[E]" + object.interact_promt
		
		if Input.is_action_just_pressed("interact"):
			object._interact()
