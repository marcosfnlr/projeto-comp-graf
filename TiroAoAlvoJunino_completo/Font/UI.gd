extends Control


onready var scoreText : Label = get_node("ScoreText")

func update_score_text (score):
	scoreText.text = "Score: " + str(score)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


