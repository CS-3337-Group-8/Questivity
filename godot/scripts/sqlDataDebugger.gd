extends Control
#variables
onready var http_request = $HTTPRequest
onready var resulttext = $labels/result

func _ready():
	pass

#Button Functions__________________________________
func _on_buttonShowTable_pressed():
	var error = http_request.request("http://localhost/server/fetch-data")
	if error != OK:
		print("Error sending request: ", error)



func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print("Request completed with code: ", response_code)
	# Convert the response body to a string if necessary
	var response_text = body.get_string_from_utf8()
	var response_dictionary = parse_json(response_text)
	resulttext.text = "Response body: " + response_dictionary.message
	#print("Response body: ", response_text)
