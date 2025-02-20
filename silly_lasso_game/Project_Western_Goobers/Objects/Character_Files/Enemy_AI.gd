extends CharacterBody2D


@export var speed = 350.0
@export var acceleration_max = 1.5
@export var acceleration_min = 0.15
@export var friction = 0.55
@export var Target_Method = "Nearest"
@onready var EnemyFolder = $".".get_parent()
@onready var game = EnemyFolder.get_parent()
@onready var PlayerFolder = game.find_child("Player_Folder")

func target_Cal() -> CharacterBody2D:
	var Tar = CharacterBody2D
	
	var Val_Check = 0
	if Target_Method == "Nearest":
		for N in PlayerFolder.get_children():
			if N.is_in_group("Players"):	
				var distance = sqrt(pow($".".position.x - N.position.x, 2) + pow($".".position.y - N.position.y, 2))
				
				if Val_Check > distance or Tar == CharacterBody2D:
					Tar = N
					Val_Check = distance
			else:
				print("No vaild targets have been found.")
	
	return Tar

func move_toward_tar(Target):
	if Target:
		## Set the direction of the Enemy towards the NERDS
		await get_tree().create_timer(0.5).timeout
		var dir = $".".position.direction_to(Target.position)
		$".".velocity = dir * speed
	
func _physics_process(delta: float) -> void:
	var Enemy_Target = target_Cal()
	move_toward_tar(Enemy_Target)
	move_and_slide()
