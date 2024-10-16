extends Control

#variables
	#onready var nodes
onready var loginUser = $Background/textfields/textboxUsername
onready var loginPassword = $Background/textfields/textboxPassword
	#HTTPRequest
onready var http_request = $HTTPRequest
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#Login button
func _on_buttonLogin_pressed():
	var error = http_request.request("http://localhost/db/users/by-username/john_doe")#testing pull
	if error != OK:
		print("Error sending request: ", error)
	#get_tree().change_scene("res://scenes/MainPage.tscn")   #moves to Main Page

#Create New Account Button
func _on_buttonCreateAcc_pressed():
	get_tree().change_scene("res://scenes/NewAccountPage.tscn") #moves to New Account Page


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_text = (body.get_string_from_utf8())
	response_text = response_text.lstrip('[')
	response_text = response_text.rstrip(']')
	var Dict = parse_json(response_text)
	print(Dict["username"])
	
