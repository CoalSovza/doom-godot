extends Node

var PROJECTION_TO_360_RATIO

func _ready():
  $Projection.player.position = $StartPosition.position
  PROJECTION_TO_360_RATIO = $Projection.ANGLE360 / 360
  var map_representation = []
  for n in $Obstacles.get_children():
    map_representation.append(
      [
        int(n.position.x / $Projection.grid_unit_size),
        int(n.position.y / $Projection.grid_unit_size)
      ]
    )
  $Projection.map_representation = map_representation

func _physics_process(delta):
  pass

func _process(delta):
  $Projection.update()
  $Player.position = $Projection.player.position
  $Player.rotation_degrees = floor($Projection.player.rotation / PROJECTION_TO_360_RATIO)
  $Debug.update_player_angle($Player.rotation_degrees)
  $Debug.update_player_position($Projection.player.position)
  $Debug.update_ray($Projection.debug_first_ray, $Projection.debug_last_ray)