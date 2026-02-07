extends RichTextLabel

@export var text_speed := 0.03   # seconds per character
var full_text := ""
var index := 0

func _ready():
    start_text("Hello player. Welcome to the system.")

func start_text(t):
    full_text = t
    text = full_text
    visible_characters = 0
    index = 0
    type_text()

func type_text():
    while index <= full_text.length():
        visible_characters = index
        index += 1
        await get_tree().create_timer(text_speed).timeout

