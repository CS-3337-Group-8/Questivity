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
onready var classCode = $labels/textClasscode
onready var textCreateAcc = $labels/textCreateAcc
	#TextBoxes
onready var textBoxUserName = $textfields/textboxUsername
onready var textBoxPassWord = $textfields/textboxPassword
onready var textBoxClassCode = $textfields/textboxClasscode
	#Signals
signal CreateUser(user, password, classcode)
	


# Called whonready varen the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StudentButton_pressed():
	studentButton.visible = false
	teacherButton.visible = false
	textRole.visible = false
	submitButton.visible = true
	username.visible = true
	password.visible = true 
	classCode.visible = true 
	textCreateAcc.visible = true
	textBoxUserName.visible = true
	textBoxPassWord.visible = true
	textBoxClassCode.visible = true


func _on_buttonSubmit_pressed():
	emit_signal("CreateUser", textBoxUserName.text, textBoxPassWord.text, textBoxClassCode.text)
	get_tree().change_scene("res://scenes/Welcome.tscn")

