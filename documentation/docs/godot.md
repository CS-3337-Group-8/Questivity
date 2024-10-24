# Godot

## Web Export Process

When the Docker container `godot-export` is running, every time you change the Godot project files, the project is automatically exported to HTML5 and WebAssembly. This enables you to see changes in real-time, streamlining the development process.

### Accessing the Project

1. Ensure the `godot-export` Docker container is running.
2. Open your web browser and navigate to `http://localhost`.
3. Click on the "Questivity" link to load the app.

## `ServerConnection` node

The `ServerConnection` class is designed to facilitate HTTP communication with your server. It extends the `Node` class, allowing it to be part of Godot's scene tree.

### Class Definition

```gdscript
extends Node
class_name ServerConnection
```

### Properties

-   `export(String) var url`:

    -   **Description**: The base URL for the server endpoint. Default is `"http://localhost/server/"`.

-   `var request_counter:int`:
    -   **Description**: A counter to generate unique signal names for each request.

### Methods

#### `_generate_signal_name()`

```gdscript
func _generate_signal_name() -> String:
```

-   **Returns**: A unique signal name for the HTTP request.
-   **Description**: Increments the request counter and returns a formatted signal name.

#### `request(endpoint:String, request_method:int, data:Dictionary)`

```gdscript
func request(endpoint: String, request_method: int, data: Dictionary) -> String:
```

-   **Parameters**:
    -   `endpoint`: The specific endpoint to which the request is sent.
    -   `request_method`: The HTTP method to be used (e.g., `HTTPClient.METHOD_GET`, `HTTPClient.METHOD_POST`, etc.).
    -   `data`: A dictionary containing the data to be sent with the request.
-   **Returns**: A unique signal name for the request.
-   **Description**: Creates a new `HTTPRequest`, connects the request completion signal, and sends the request to the server. If an error occurs while sending the request, it prints the error message.

#### `_on_request_completed(result, response_code, headers, body, http_request, signal_name)`

```gdscript
func _on_request_completed(result: int, response_code: int, headers: Array, body: String, http_request: HTTPRequest, signal_name: String):
```

-   **Parameters**:
    -   `result`: The result of the HTTP request.
    -   `response_code`: The HTTP response code returned by the server.
    -   `headers`: An array of headers returned by the server.
    -   `body`: The response body as a string.
    -   `http_request`: The `HTTPRequest` instance.
    -   `signal_name`: The unique signal name associated with the request.
-   **Description**: Handles the completion of the HTTP request. It parses the response and emits the signal with the JSON data if it exists.

#### `httpPost(endpoint:String, data:Dictionary)`

```gdscript
func httpPost(endpoint: String, data: Dictionary) -> String:
```

-   **Parameters**:
    -   `endpoint`: The specific endpoint for the POST request.
    -   `data`: The data to send with the request.
-   **Returns**: A unique signal name for the request.
-   **Description**: A helper function to simplify sending POST requests.

#### `httpGet(endpoint:String, data:Dictionary)`

```gdscript
func httpGet(endpoint: String, data: Dictionary) -> String:
```

-   **Parameters**:
    -   `endpoint`: The specific endpoint for the GET request.
    -   `data`: The data to send with the request.
-   **Returns**: A unique signal name for the request.
-   **Description**: A helper function to simplify sending GET requests.

#### `httpPut(endpoint:String, data:Dictionary)`

```gdscript
func httpPut(endpoint: String, data: Dictionary) -> String:
```

-   **Parameters**:
    -   `endpoint`: The specific endpoint for the PUT request.
    -   `data`: The data to send with the request.
-   **Returns**: A unique signal name for the request.
-   **Description**: A helper function to simplify sending PUT requests.

#### `httpDelete(endpoint:String, data:Dictionary)`

```gdscript
func httpDelete(endpoint: String, data: Dictionary) -> String:
```

-   **Parameters**:
    -   `endpoint`: The specific endpoint for the DELETE request.
    -   `data`: The data to send with the request.
-   **Returns**: A unique signal name for the request.
-   **Description**: A helper function to simplify sending DELETE requests.

---

### Example

To use the `ServerConnection` node, you can call its HTTP methods and connect the returned signal names to handle responses. Here’s how:

```gdscript
extends Node

var server_connection: ServerConnection

func _ready():
    server_connection = $ServerConnection

    # Example: Sending a GET request
    var signal_name = server_connection.httpGet("api/endpoint", {})
    server_connection.connect(signal_name, self, "_on_request_completed")

func _on_request_completed(json_data):
    print("Response Code: ", json_data.response_code)
    print("Data Received: ", json_data)
```

## Detailed Examples

### Sending a POST Request

To send a POST request, use the `httpPost` method and connect to the returned signal name:

```gdscript
func send_data():
    var post_data = {
        "key1": "value1",
        "key2": "value2"
    }

    var signal_name = server_connection.httpPost("api/data", post_data)
    server_connection.connect(signal_name, self, "_on_post_request_completed")

func _on_post_request_completed(json_data):
    print("POST Response Code: ", json_data.response_code)
    print("POST Data Received: ", json_data)
```

### Sending a PUT Request

For updating existing data, use the `httpPut` method:

```gdscript
func update_data():
    var update_data = {
        "key": "new_value"
    }

    var signal_name = server_connection.httpPut("api/data/1", update_data)
    server_connection.connect(signal_name, self, "_on_put_request_completed")

func _on_put_request_completed(json_data):
    print("PUT Response Code: ", json_data.response_code)
    print("PUT Data Received: ", json_data)
```

### Sending a DELETE Request

To delete data, use the `httpDelete` method:

```gdscript
func delete_data():
    var signal_name = server_connection.httpDelete("api/data/1", {})
    server_connection.connect(signal_name, self, "_on_delete_request_completed")

func _on_delete_request_completed(json_data):
    print("DELETE Response Code: ", json_data.response_code)
    print("DELETE Data Received: ", json_data)
```
