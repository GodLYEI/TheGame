extends RichTextLabel

@export var text_speed := 0.02   # seconds per character
var full_text := ""
var index := 0

var msg = [
	"Absolute efficiency does not equal justice.",
	"AI may be neutral, but it is shaped by economic interests.",
	"Responsibility and progress can coexist.",
	"AI reflects the best values of those who create it."
]

func start_text(type):
	full_text = msg[type]
	text = full_text
	visible_characters = 0
	index = 0
	type_text()

func type_text():
	while index <= full_text.length():
		visible_characters = index
		index += 1
		await get_tree().create_timer(text_speed).timeout
