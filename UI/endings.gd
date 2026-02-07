extends RichTextLabel

@export var text_speed := 0.02   # seconds per character
var full_text := ""
var index := 0

var ending = [
	"The AI achieved perfect efficiency. Crime disappeared. So did freedom. People were safe, but no longer free.",
	"The AI changed the world, but only for those who could afford it. Progress continued, while inequality quietly grew.",
	"The AI became a powerful tool, yet carefully restrained. Society moved forward, one cautious decision at a time.",
	"The AI learned more than logic. It learned responsibility. Technology did not replace humanity, it protected it."
]

func start_text(type):
    full_text = ending[type]
    text = full_text
    visible_characters = 0
    index = 0
    type_text()

func type_text():
    while index <= full_text.length():
        visible_characters = index
        index += 1
        await get_tree().create_timer(text_speed).timeout
