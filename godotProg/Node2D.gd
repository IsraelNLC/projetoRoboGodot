extends Node2D

# Variáveis de objetos da cena
onready var linha := $Line2D
onready var sprite := $Sprite
onready var base := $Icon2

# Variáveis base para posicionamento dos objetos 
onready var posMiddle := Vector2(get_viewport_rect().size.x/2 - 14,get_viewport_rect().size.y/2 + 50)
onready var posPoint := Vector2(0,0)


func _ready():
	# Setar as posições da base do "robô"
	base.position.x = posMiddle.x + base.texture.get_size().x/2 - 2
	base.position.y -= 15
	base.scale.x = 1.25
	base.scale.y = 1.25
	# Cria o ponto fixo e o ponto para manipulação do "braço"
	linha.add_point(posMiddle,0)
	linha.add_point(posPoint,1)


func _process(delta):
	# Atualiza as coordenadas do braço em relação às cordenadas da sprite da ponta
	posPoint.x = sprite.position.x - (sprite.texture.get_size().x/2 - 2)
	posPoint.y = sprite.position.y - (sprite.texture.get_size().y/2)
	linha.set_point_position(1,posPoint)

	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
