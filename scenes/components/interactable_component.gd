class_name InteractableComponent
extends Area2D


signal interactable_activated
signal interactable_deactivated


func _on_body_entered(body: Node2D) -> void:
	print(body.name, " entered the interactable body")
	interactable_activated.emit()


func _on_body_exited(body: Node2D) -> void:
	print(body.name, " exited the interactable body")
	interactable_deactivated.emit()
