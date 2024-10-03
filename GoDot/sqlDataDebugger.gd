extends Control
#variables
	#onready var
onready var result = $labels/TextSQLResults
onready var username = $textboxs/textboxUsername
onready var password = $textboxs/textboxPassword
onready var classcode = $textboxs/textboxClasscode
onready var table = $textboxs/textboxTable

	#constructs
const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
	#Actual Variables
var database #create database
var databasePath = "res://databaseStorage/database" #path to database

func _ready():
	activateDatabaseEdit() 

#SQL Functions____________________________________
func activateDatabaseEdit():
	database = SQLite.new()
	database.path = databasePath
	
func addDataToExistingDatabase(): #create an sql file table sample
	database.open_db()
	var tableName = table.text
	var accountDictionary : Dictionary = Dictionary()
	accountDictionary["username"] = username.text
	accountDictionary["password"] = password.text
	accountDictionary["classcode"] = int(classcode.text)
	
	database.insert_row(tableName, accountDictionary)
	clearAllTextBoxes()
		
func readFromDatabase(): #Sample Table (accountInfo)
	database.open_db()
	var tableName = "accountInfo"
	database.query("select * from " + tableName + ";")
	for i in range(0, database.query_result.size()):
		result.text = "Qurey results: " + database.query_result[i]["username"] + " " + database.query_result[i]["password"] + " " + str(database.query_result[i][("classcode")])

#Button Functions__________________________________
func _on_buttonShowTable_pressed():
	readFromDatabase()

func _on_buttonAddRow_pressed():
	addDataToExistingDatabase()
	
func clearAllTextBoxes():
	username.text = ""
	password.text = ""
	classcode.text = ""
	table.text = ""
