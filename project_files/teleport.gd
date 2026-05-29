extends XRController3D

@onready var ray: RayCast3D = $TeleportRay
@onready var marker: MeshInstance3D = $TeleportMarker

#Zmienne do obrotu - kąt, flaga 
@export var snap_turn_angle: float = 45.0
@export var turn_deadzone: float = 0.5
var can_snap_turn: bool = true

var xr_origin: XROrigin3D
var xr_camera: XRCamera3D

func _ready() -> void:
	xr_origin = get_parent() as XROrigin3D
	xr_camera = xr_origin.get_node("XRCamera3D") as XRCamera3D
	marker.visible = false
	self.button_pressed.connect(self._on_button_pressed)

func _process(_delta: float) -> void:
	if ray.is_colliding():
		marker.global_transform.origin = ray.get_collision_point()
		marker.visible = true
	else:
		marker.visible = false
		
	# Funkcja obrotu
	handle_snap_turn()

# OBRÓT SKOKOWY
func handle_snap_turn() -> void:
	var joy: Vector2 = get_vector2("thumbstick")

	# odblokuj obrót jeżeli puści gałkę
	if abs(joy.x) < turn_deadzone:
		can_snap_turn = true
		return

	# Jeśli gracz wychylił gałkę i obrót jest dozwolony
	if can_snap_turn:
		# Zapisujemy pozycję głowy przed obrotem
		var pos_before = xr_camera.global_position

		# Wykonujemy obrót bazy
		if joy.x > 0:
			xr_origin.rotate_y(deg_to_rad(-snap_turn_angle)) # W prawo
		else:
			xr_origin.rotate_y(deg_to_rad(snap_turn_angle))  # W lewo

		# Korygujemy przesunięcie (żeby gracz nie kręcił się jak na karuzeli, 
		# tylko obracał w miejscu, w którym aktualnie stoi jego głowa)
		var pos_after = xr_camera.global_position
		var delta_pos = pos_before - pos_after
		xr_origin.global_position += delta_pos
		
		# Blokujemy obrót, dopóki gracz nie puści gałki
		can_snap_turn = false

func teleport_now() -> void:
	if not ray.is_colliding():
		return
	var target: Vector3 = ray.get_collision_point()

	var origin_tf := xr_origin.global_transform
	var cam_tf := xr_camera.global_transform
	var cam_offset := cam_tf.origin - origin_tf.origin
	cam_offset.y = 0.0
	origin_tf.origin = Vector3(target.x - cam_offset.x, 0.0, target.z - cam_offset.z)
	xr_origin.global_transform = origin_tf

func _on_button_pressed(button_name: String) -> void:
	print("Wciśnięto przycisk: ", button_name) 
	if button_name == "trigger_click":
		print("RayCast uderza w: ", ray.is_colliding()) 
		teleport_now()
