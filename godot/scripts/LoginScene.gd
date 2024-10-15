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
	
	get_tree().change_scene("res://scenes/MainPage.tscn")   #moves to Main Page

#Create New Account Button
func _on_buttonCreateAcc_pressed():
	get_tree().change_scene("res://scenes/NewAccountPage.tscn") #moves to New Account Page


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	pass # Replace with function body.
