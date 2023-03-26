extends Node2D

var URL = "http://127.0.0.1:3000/axes"
@export
var axes: String

func _on_button_button_down():
	$HTTPRequest.cancel_request()
	axes = $HTTPRequest.request(URL)


func _on_http_request_request_completed(result, response_code, headers, body):
	
	if (response_code == 200):
		var data = body.get_string_from_utf8()
		print(data)
		return data
	else:
		print('response_code: ', response_code)
		print('problem on the server')
