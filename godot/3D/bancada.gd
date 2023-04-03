extends Node3D

var XYZ_Axes = Vector3(0,0,0)
var a
var b
var c
var r
@export var URL = "http://127.0.0.1:3000/axes"

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request(URL)
	

func forward_kinematics(base, forearm, arm, hand):
	var basis = $EixoBase.transform.basis
	var origin = Vector3(0,1,0)
	var base_transform3d = Transform3D(basis, origin)
	
	base.transform = base.transform.rotated(origin, 0.5)
	forearm.transform = forearm.transform.rotated_local(Vector3(0,0,1), 0.5)
	arm.transform = arm.transform.rotated_local(Vector3(0,0,1), 0.5)
	hand.transform = hand.transform.rotated_local(Vector3(0,1,0), 0.5)
	
func inverse_kinematics(base, forearm, arm, hand):
	base.rotate_y(atan2(XYZ_Axes[1], XYZ_Axes[0]))
	var q3 = acos(( forearm.transform.origin.distance_to(hand.transform.origin) - 8 ) / 8)
	forearm.rotate_z(q3)
	var res = sqrt(abs(pow(forearm.transform.origin.distance_to(hand.transform.origin), 2) - (pow(XYZ_Axes[0], 2) + pow(XYZ_Axes[1], 2))))
	arm.rotate_z(atan2(res, sqrt(pow(XYZ_Axes[0], 2) + pow(XYZ_Axes[1], 2))) - atan2(sin(q3)*2, 2 + cos(q3))*2)
	pass

func clear(base, forearm, arm, hand):
	base.transform.basis = Basis()
	base.transform.origin = Vector3(0,0,0)
	forearm.transform.origin = Vector3(0,3,0)
	forearm.transform.basis = Basis()
	arm.transform.origin = Vector3(0,3,0)
	arm.transform.basis = Basis()
	hand.transform.origin = Vector3(3,0,0)
	hand.transform.basis = Basis()


func _on_http_request_request_completed(result, response_code, headers, body):
	var axes = body.get_string_from_utf8()
	var data = JSON.parse_string(axes)
	print(data)
	XYZ_Axes = Vector3(data["x"], data["y"], data["z"])
	a = data["a"]
	b = data["b"]
	c = data["c"]
	r = data["r"]
	$HTTPRequest.cancel_request()

func _on_button_pressed():
	$HTTPRequest.request(URL)
	var base = $EixoBase
	var forearm = $EixoBase/EixoForearm
	var arm = $EixoBase/EixoForearm/EixoArm
	var hand = $EixoBase/EixoForearm/EixoArm/EixoHand
	clear(base, forearm, arm, hand)
	forward_kinematics(base, forearm, arm, hand)


func _on_inverse_kinematics_pressed():
	$HTTPRequest.request(URL)
	var base = $EixoBase
	var forearm = $EixoBase/EixoForearm
	var arm = $EixoBase/EixoForearm/EixoArm
	var hand = $EixoBase/EixoForearm/EixoArm/EixoHand
	clear(base, forearm, arm, hand)
	inverse_kinematics(base, forearm, arm, hand)
