extends CanvasLayer

@export var Questions : Control
@export var Player : CharacterBody2D
@export var Introduce : Control
@export var IntroLabel : Label # <-- Kéo node Label trong Introduce vào đây

var ethic_values_pressing_yes = [-10, -15, -10, -15, -10, -10, 15, 10, 15, 10, 10, 15, 15, 10, 10, 10]
var ethic_values_pressing_no = [10, 15, 10, 10, 15, 10, -15, -10, -15, -10, -10, -15, -15, -10, -10, -10]

var cur_question = 0;

# --- THÊM DỮ LIỆU HỘI THOẠI ---
var intro_lines = [
	"AI learns from rewards and punishments.",
	"Reward good actions, punish bad ones.",
	"Your choices guide the AI’s ethics."
]
var cur_intro_index = 0

func _ready():
	randomize()
	shuffle_children(Questions, ethic_values_pressing_yes, ethic_values_pressing_no)
	Questions.get_child(0).visible = true

	# for i in ethic_values_pressing_yes:
	# 	print(i)
		
	# for i in ethic_values_pressing_no:
	# 	print(i)
	if IntroLabel:
		IntroLabel.text = intro_lines[0]
		
# --- THÊM HÀM XỬ LÝ NÚT BẤM CHO INTRO ---
func _input(event):
	if not self.visible: 
		return
	# Nếu Introduce đã ẩn rồi thì không làm gì cả
	if not Introduce.visible: return

	# Kiểm tra nút bấm (E, Space hoặc Enter tùy bạn cài đặt ui_accept)
	if event.is_action_pressed("ui_accept"):
		print("print")
		cur_intro_index += 1
		
		if cur_intro_index < intro_lines.size():
			# Vẫn còn thoại -> Hiện câu tiếp theo
			if IntroLabel:
				IntroLabel.text = intro_lines[cur_intro_index]
		else:
			# Hết thoại -> Chỉ đơn giản là ẩn Introduce đi (Đúng yêu cầu)
			fade_out_introduce()

func fade_out_introduce():
	# Tạo một Tween mới
	var tween = get_tree().create_tween()
	
	# Thực hiện giảm độ alpha (modulate:a) từ 1 về 0 trong 0.5 giây
	tween.tween_property(Introduce, "modulate:a", 0.0, 0.5)
	
	# Sau khi mờ hẳn thì mới đặt visible = false để giải phóng chuột/focus
	tween.tween_callback(func(): Introduce.visible = false)

func swap(arr, i, j):
	var temp = arr[i]
	arr[i] = arr[j]
	arr[j] = temp

func shuffle_children(parent: Node, yes, no):
	var children = parent.get_children()

	for i in range(children.size() - 1, 0, -1):
		var j = randi() % (i + 1)

		parent.move_child(parent.get_child(i), j)
		swap(yes, i, j)
		swap(no, i, j)
		
func update_visibility(id, value):
	Questions.get_child(id).visible = value

func is_vaild_question(id):
	return id < Questions.get_child_count()

func on_button_pressed():

	update_visibility(cur_question, false);

	cur_question += 1
	if (not is_vaild_question(cur_question)): return

	update_visibility(cur_question, true);


func _on_no_button_pressed() -> void:
	if (not is_vaild_question(cur_question)): return
	Player.modify_ethic(ethic_values_pressing_no[cur_question])
	on_button_pressed()


func _on_yes_button_pressed() -> void:
	if (not is_vaild_question(cur_question)): return
	Player.modify_ethic(ethic_values_pressing_yes[cur_question])
	on_button_pressed()


func _on_computer_ui_vxcode_pressed() -> void:
	visible = true	
