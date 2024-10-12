extends Control

#variables
	#onready var
onready var loginUser = $Background/textfields/textboxUsername
onready var loginPassword = $Background/textfields/textboxPassword
	#Custom signals
signal loginUser(user, password)
	#database
#const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
	#Actual Variables
#var database #create database
#var databasePath = "res://databaseStorage/database" #path to database

#export var: exporting member variables is to have them visible and editable in the editor


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#activateDatabaseEdit()
	#addDataToExistingDatabase()
	#readFromDatabase()
	

#Login button
func _on_buttonLogin_pressed():
	emit_signal("loginUser", loginUser.text, loginPassword.text)
	get_tree().change_scene("res://scenes/MainPage.tscn")   #moves to Main Page

#Create New Account Button
func _on_buttonCreateAcc_pressed():
	get_tree().change_scene("res://scenes/NewAccountPage.tscn") #moves to New Account Page
