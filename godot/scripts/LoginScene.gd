extends Control

#variables
	#onready var nodes
onready var loginUser = $Background/textfields/textboxUsername
onready var loginPassword = $Background/textfields/textboxPassword
onready var connection = $ServerConnection
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var read_signal = connection.httpGet("", {})
	connection.connect(read_signal, self, "_on_read_completed")


#Login button
func _on_buttonLogin_pressed():
	# takes what the textboxes input
	var loginInput: Dictionary = {
		"username": loginUser.text,
		"password": loginPassword.text
	}
	# signal gives access to page 
	var login_signal = connection.httpPost("users/login/", loginInput)
	connection.connect(login_signal, self, "on_credential_check_completed")
	
	
	#get_tree().change_scene("res://scenes/MainPage.tscn")   #moves to Main Page

#Create New Account Button
func _on_buttonCreateAcc_pressed():
	get_tree().change_scene("res://scenes/NewAccountPage.tscn") #moves to New Account Page

#
#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	var response_text = (body.get_string_from_utf8())
#	response_text = response_text.lstrip('[')
#	response_text = response_text.rstrip(']')
#	var Dict = parse_json(response_text)
#	print(Dict["username"])

func _on_read_completed(json_data):
	print("Read Data:" + str(json_data))
	
func on_credential_check_completed(json_data):
	print("Read Data:" + str(json_data))
	if json_data.has('data'):
		if json_data.data.is_instructor:
			get_tree().change_scene("res://scenes/teacherHub.tscn") #moves
		else:
			get_tree().change_scene("res://scenes/studentHub.tscn") #moves
	print(json_data.has('data'))
	

