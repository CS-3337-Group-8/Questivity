extends Node
class_name ServerConnection

export(String) var url = "http://localhost/server/"
var request_counter:int = 0

func _generate_signal_name():
	request_counter += 1
	return "request_completed_signal_" + str(request_counter)

func request(endpoint:String, request_method:int, data:Dictionary):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	var signal_name = _generate_signal_name()
	
	self.add_user_signal(signal_name, [{"name": "json_data", "type": TYPE_DICTIONARY}])
	
	http_request.connect("request_completed", self, "_on_request_completed", [http_request, signal_name])
	
	var error = http_request.request(url + endpoint, ["Content-Type: application/json"], true, request_method, to_json(data))
	if error != OK:
		print("Error sending request: ", error)
		
	return signal_name
	
func _on_request_completed(result, response_code, headers, body, http_request, signal_name):
	var response_text = body.get_string_from_utf8()
	
	var json_data = parse_json(response_text)
	json_data.response_code = response_code
	
	if has_signal(signal_name):
		emit_signal(signal_name, json_data)
		
	remove_child(http_request)

func httpPost(endpoint:String, data:Dictionary):
	return request(endpoint, HTTPClient.METHOD_POST, data)

func httpGet(endpoint:String, data:Dictionary):
	return request(endpoint, HTTPClient.METHOD_GET, data)
		
func httpPut(endpoint:String, data:Dictionary):
	return request(endpoint, HTTPClient.METHOD_PUT, data)
		
func httpDelete(endpoint:String, data:Dictionary):
	return request(endpoint, HTTPClient.METHOD_DELETE, data)
