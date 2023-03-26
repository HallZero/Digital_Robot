extends Control

var url = "http://127.0.0.1:3000/test"

func _on_backend_request_request_completed(result, response_code, headers, body):
	print("PORRA")
	print(result)


func _on_button_toggled(button_pressed):
	$BackendRequest.request(url)
	
