extends Sprite

func _process(delta):
	# Centraliza e atualiza as posições com nas informações do HTTP request
	position.x = (get_viewport_rect().size.x + texture.get_size().x/2) / 2 + getRequests()[0] * 3
	position.y = (get_viewport_rect().size.y / 2) - getRequests()[1] * 3
	if getRequests()[2] < 6:
		scale.x = getRequests()[2]/5 + 0.25
		scale.y = getRequests()[2]/5 + 0.25
	else:
		# Tratativa para o sprite não ficar gigante
		scale.x = getRequests()[2]/6 + 0.3
		scale.y = getRequests()[2]/6 + 0.3

# Função que importa a requisição do outro script
func getRequests():
	var impHTTP = get_parent().get_node("Sprite/HTTPRequest").arrayPositions
	return impHTTP
