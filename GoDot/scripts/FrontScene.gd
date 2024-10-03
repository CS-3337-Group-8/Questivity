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
	
	
#func activateDatabaseEdit():
#	database = SQLite.new()
#	database.path = databasePath
#
#func addDataToExistingDatabase(): #create an sql file table sample
#	database.open_db()
#	var tableName = "accountInfo"
#	var accountDictionary : Dictionary = Dictionary()
#	accountDictionary["username"] = "MinecraftSteve"
#	accountDictionary["password"] = "schoolsuck2024"
#	accountDictionary["classcode"] = 1234
#
#	database.insert_row(tableName, accountDictionary)
#
#func readFromDatabase():
#	database.open_db()
#	var tableName = "accountInfo"
#	database.query("select * from " + tableName + ";")
#	for i in range(0, database.query_result.size()):
#		print("Qurey results ", database.query_result[i]["username"], " ", database.query_result[i]["password"], " ", database.query_result[i]["classcode"])
	
	#run the function to create the table with the variable you just made
	#.create_table(table Name, table)
	
	#("accountInfo", table)

#Login button
func _on_buttonLogin_pressed():
	emit_signal("loginUser", loginUser.text, loginPassword.text)
	get_tree().change_scene("res://scenes/MainPage.tscn")   #moves to Main Page

#Create New Account Button
func _on_buttonCreateAcc_pressed():
	get_tree().change_scene("res://scenes/NewAccountPage.tscn") #moves to New Account Page
