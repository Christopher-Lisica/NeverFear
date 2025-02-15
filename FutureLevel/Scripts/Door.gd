extends Node2D

# References to the AnimatedSprite2D, StaticBody2D, and Area2D nodes
@onready var animated_sprite = %AnimatedSprite2D
@onready var trigger_area = $Area2D
@onready var door_shape: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var player = get_node("../Hero")
@onready var static_body_2d: AnimatableBody2D = $StaticBody2D


var has_sound_played: bool = false 
# Called when the node enters the scene tree
func _ready():
	# Set the initial animation to the closed state
	animated_sprite.animation = "closed"
	
	# Initially, the StaticBody2D should block the player by being on the same layer as the play
	
	# Connect the signal for body_entered to the appropriate function
	trigger_area.connect("body_entered", Callable(self, "_on_player_entered"))

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D



func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		if not has_sound_played:
			audio_stream_player_2d.play()
			has_sound_played = true
		if animated_sprite.animation != "open":
			animated_sprite.play("open")
			$StaticBody2D/CollisionShape2D.call_deferred("set_disabled", true)
			
