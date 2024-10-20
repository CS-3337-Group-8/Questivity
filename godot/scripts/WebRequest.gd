extends HTTPRequest

export(String) var url = "http://localhost/server/"
onready var http_request
var jsonData: Dictionary

signal SendJsonData(jsonData)

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	print(http_request) #[HTTPRequest: 1324]
	http_request.connect("request_completed", self, "_on_request_completed")
	print(self.read("", {"username":"admin", "password":"password"})) #Null

	
func create(endpoint:String, data:Dictionary):
	print("conection revieved")
	var error = http_request.request(url + endpoint, [], true, HTTPClient.METHOD_POST, to_json(data))
	if error != OK:
		print("Error sending request: ", error)

func read(endpoint:String, data:Dictionary):
	var error = http_request.request(url + endpoint)
	if error != OK:
		print("Error sending request: ", error)
	
		
func update(endpoint:String, data:Dictionary):
	var error = http_request.request(url + endpoint)
	if error != OK:
		print("Error sending request: ", error)
		
func destroy(endpoint:String, data:Dictionary):
	var error = http_request.request(url + endpoint)
	if error != OK:
		print("Error sending request: ", error)
		
		
func _on_request_completed(result, response_code, headers, body):
	print("Request completed with code: ", response_code) #request completed
	var response_text = body.get_string_from_utf8()
	print("Response body: ", response_text) #Responsebody
	var json_data = parse_json(response_text)
	return json_data

