extends Control


# Declare member variables here. Examples:
onready var background = $Background
onready var studentButton = $StudentButton
onready var teacherButton = $TeacherButton
onready var submitButton = $submitButton
onready var promptLabel = $promptLabel
onready var username = $textUsername
onready var password = $textPassword
onready var classCode = $textClasscode
onready var welcome = $textWelcome
onready var textBoxUserName = $textfields/textboxUsername
onready var textBoxPassWord = $textfields/textboxPassword
onready var textBoxClassCode = $textfields/textboxClasscode


# Called whonready varen the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StudentButton_pressed():
	studentButton.visible = false
	teacherButton.visible = false
	promptLabel.visible = false
	submitButton.visible = true
	username.visible = true
	password.visible = true 
	classCode.visible = true 
	welcome.visible = true
	welcome.visible = true
	textBoxUserName.visible = true
	textBoxPassWord.visible = true
	textBoxClassCode.visible = true
	

	
