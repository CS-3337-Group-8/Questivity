extends Control


# Declare variables
	#Pane
onready var background = $Background
	#Button
onready var studentButton = $buttons/buttonStudent
onready var teacherButton = $buttons/buttonTeacher
onready var submitButton = $buttons/buttonSubmit
	#Labels
onready var textRole = $labels/textRole
onready var username = $labels/textUsername
onready var password = $labels/textPassword
onready var textCreateAcc = $labels/textCreateAcc
onready var errorMessage = $labels/textErrorMessage
	#TextBoxes
onready var textBoxUserName = $textfields/textboxUsername
onready var textBoxPassWord = $textfields/textboxPassword
	#HTTPRequest
onready var connection = $ServerConnection
	
var isInstructor = false

	#Signals
signal CreateUser(user, password, classcode)



func _ready():
	var read_signal = connection.httpGet("", {})
	connection.connect(read_signal, self, "_on_read_completed")


func _on_StudentButton_pressed():
	isInstructor = false
	studentButton.visible = false
	teacherButton.visible = false
	textRole.visible = false
	submitButton.visible = true
	username.visible = true
	password.visible = true 
	textCreateAcc.visible = true
	textBoxUserName.visible = true
	textBoxPassWord.visible = true


func _on_buttonTeacher_pressed():
	isInstructor = true
	studentButton.visible = false
	teacherButton.visible = false
	textRole.visible = false
	submitButton.visible = true
	username.visible = true
	password.visible = true 
	textCreateAcc.visible = true
	textBoxUserName.visible = true
	textBoxPassWord.visible = true

func _on_buttonSubmit_pressed():
	var registerInput: Dictionary = {
		"username": textBoxUserName.text,
		"password": textBoxPassWord.text,
		"is_instructor": isInstructor
	}
	var login_signal = connection.httpPost("users/register/", registerInput)
	connection.connect(login_signal, self, "_on_register_check_completed")
	textBoxUserName.text = ""
	textBoxPassWord.text = ""
	

func _on_read_completed(json_data):
	print("Read Data:" + str(json_data))
	
func _on_register_check_completed(json_data):
	print("Read Data:" + str(json_data))
	
	if json_data.response_code >= 200 && json_data.response_code < 300:
		get_tree().change_scene("res://scenes/Welcome.tscn")
	else:
		errorMessage.visible = true
		errorMessage.text = str(json_data)
	


