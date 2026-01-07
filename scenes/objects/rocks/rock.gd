extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(damage: int) -> void:
	damage_component.apply_damage(damage)

# signal from damage_compoenent that tells us that our object is now ready to break and collected.
func on_max_damage_reached() -> void:
	call_deferred("add_stone_scene")
	print("Max damage reached.")
	queue_free()

func add_stone_scene() -> void:
	var parent := get_parent()
	var offsets := [Vector2(0,-4), Vector2(0, 4), Vector2(-4, 0), Vector2(4, 0)]
	for off in offsets:
		var stone_instance = stone_scene.instantiate() as Node2D
		stone_instance.global_position = global_position + off
		parent.add_child(stone_instance)
