extends HTTPRequest

# Array para salvas as pocições
var arrayPositions = [0,0,5]

func _process(delta):
	# Faz sucessivas requisições HTTP
	self.connect("request_completed", self, "_on_request_completed")
	var err = self.request("http://127.0.0.1:3000/getlast")
	if err != OK:
		push_error("Um erro ocorreu!")

# Função que recebe os dados da requisição e os inputa no array
func _on_request_completed(result, response_code, headers, body):
	var positions = parse_json(body.get_string_from_utf8())
	arrayPositions[0] = positions[0]["x"]
	arrayPositions[1] = positions[0]["y"]
	arrayPositions[2] = positions[0]["z"]
