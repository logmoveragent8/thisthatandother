extends Node2D

# Brain Kingdom - Main Game Scene

# Game State
var current_level: int = 1
var stars: int = 0
var coins: int = 100
var streak: int = 0
var current_puzzle: Dictionary = {}
var attempts: int = 0
var time_remaining: float = 30.0
var game_active: bool = false

# UI References
@onready var level_label: Label = $CanvasLayer/UI/LevelLabel
@onready var stars_label: Label = $CanvasLayer/UI/StarsLabel
@onready var coins_label: Label = $CanvasLayer/UI/CoinsLabel
@onready var timer_label: Label = $CanvasLayer/UI/TimerLabel
@onready var question_label: Label = $CanvasLayer/UI/QuestionLabel
@onready var answer_input: LineEdit = $CanvasLayer/UI/AnswerInput
@onready var feedback_label: Label = $CanvasLayer/UI/FeedbackLabel

# Realm Thresholds
var realms: Array = [
	{"name": "Grove", "start": 1, "end": 400},
	{"name": "Village", "start": 401, "end": 800},
	{"name": "Town", "start": 801, "end": 1200},
	{"name": "City", "start": 1201, "end": 1600},
	{"name": "Kingdom", "start": 1601, "end": 1900},
	{"name": "Empire", "start": 1901, "end": 2000}
]

func _ready() -> void:
	randomize()
	update_ui()
	load_puzzle()

func _process(delta: float) -> void:
	if game_active and time_remaining > 0:
		time_remaining -= delta
		timer_label.text = str(int(time_remaining)) + "s"
		if time_remaining <= 0:
			handle_timeout()

func update_ui() -> void:
	level_label.text = "Level " + str(current_level) + " - " + get_realm_name()
	stars_label.text = "⭐ " + str(stars)
	coins_label.text = "🪙 " + str(coins)

func get_realm_name() -> String:
	for realm in realms:
		if current_level >= realm["start"] and current_level <= realm["end"]:
			return realm["name"]
	return "Unknown"

func load_puzzle() -> void:
	game_active = true
	attempts = 0
	time_remaining = 30.0
	feedback_label.text = ""
	answer_input.text = ""
	
	current_puzzle = generate_puzzle(current_level)
	question_label.text = current_puzzle["question"]
	update_ui()

func generate_puzzle(level: int) -> Dictionary:
	var realm = get_realm_name()
	var puzzle_types = ["math", "riddle", "science", "pattern"]
	var selected_type = puzzle_types[randi() % puzzle_types.size()]
	
	match selected_type:
		"math":
			return generate_math_puzzle(level)
		"riddle":
			return generate_riddle_puzzle(level)
		"science":
			return generate_science_puzzle(level)
		"pattern":
			return generate_pattern_puzzle(level)
	
	return generate_math_puzzle(level)

func generate_math_puzzle(level: int) -> Dictionary:
	var p: Dictionary = {}
	
	if level <= 100:  # Grove - Basic arithmetic
		var ops = ["+", "-", "*"]
		var a = randi() % 20 + 1
		var b = randi() % 20 + 1
		var op = ops[randi() % 2]  # Only + and - for early levels
		var answer = 0
		match op:
			"+": answer = a + b
			"-": answer = a - b
			"*": answer = a * b
		p = {
			"question": str(a) + " " + op + " " + str(b) + " = ?",
			"answer": str(answer),
			"type": "math",
			"difficulty": "easy"
		}
	elif level <= 300:  # Grove - More arithmetic
		var ops = ["+", "-", "*", "/"]
		var a = randi() % 50 + 1
		var b = randi() % 10 + 1
		var op = ops[randi() % 3]
		var answer = 0
		match op:
			"+": answer = a + b
			"-": answer = a - b
			"*": answer = a * b
			"/": 
				a = a * b  # Make it divisible
				answer = a / b
		p = {
			"question": str(a) + " " + op + " " + str(b) + " = ?",
			"answer": str(answer),
			"type": "math",
			"difficulty": "easy"
		}
	elif level <= 600:  # Village - Algebra
		var x = randi() % 20 + 1
		var b = randi() % 10
		var op = ["+", "-"][randi() % 2]
		var question = "x " + op + " " + str(b) + " = " + str(x + b if op == "+" else x + b)
		p = {
			"question": "Solve: x " + op + " " + str(b) + " = " + str(x + b if op == "+" else x + b),
			"answer": str(x),
			"type": "math",
			"difficulty": "medium"
		}
	else:  # Harder math
		var a = randi() % 100 + 10
		var b = randi() % 50 + 10
		var op = ["+", "-", "*"][randi() % 3]
		var answer = 0
		match op:
			"+": answer = a + b
			"-": answer = a - b
			"*": answer = a * b
		p = {
			"question": str(a) + " " + op + " " + str(b) + " = ?",
			"answer": str(answer),
			"type": "math",
			"difficulty": "medium"
		}
	
	return p

func generate_riddle_puzzle(level: int) -> Dictionary:
	var riddles = [
		{"q": "I have cities, but no houses. I have mountains, but no trees. I have water, but no fish. What am I?", "a": "map"},
		{"q": "What has keys but no locks, space but no room, and you can enter but can't go inside?", "a": "keyboard"},
		{"q": "I speak without a mouth and hear without ears. I have no body, but I come alive with wind.", "a": "echo"},
		{"q": "The more of this there is, the less you see. What is it?", "a": "darkness"},
		{"q": "What comes once in a minute, twice in a moment, but never in a thousand years?", "a": "m"},
		{"q": "I have legs but cannot walk. What am I?", "a": "table"},
		{"q": "What is full of holes but still holds water?", "a": "sponge"},
		{"q": "What can you hold in your left hand but not in your right?", "a": "elbow"},
		{"q": "What has a head and a tail but no body?", "a": "coin"},
		{"q": "The person who makes it has no need of it; the person who buys it has no use for it. The person who uses it can neither see nor feel it. What is it?", "a": "coffin"}
	]
	
	var idx = (level - 1) % riddles.size()
	var r = riddles[idx]
	return {
		"question": "🏷️ " + r["q"],
		"answer": r["a"].to_lower(),
		"type": "riddle",
		"difficulty": "medium"
	}

func generate_science_puzzle(level: int) -> Dictionary:
	var facts = [
		{"q": "What planet is known as the Red Planet?", "a": "mars"},
		{"q": "What is H2O commonly known as?", "a": "water"},
		{"q": "What gas do plants absorb from the atmosphere?", "a": "co2"},
		{"q": "What is the largest planet in our solar system?", "a": "jupiter"},
		{"q": "What is the speed of light (approximately)?", "a": "300000"},
		{"q": "What is the chemical symbol for gold?", "a": "au"},
		{"q": "How many bones are in the adult human body?", "a": "206"},
		{"q": "What is the hardest natural substance on Earth?", "a": "diamond"},
		{"q": "What planet is closest to the Sun?", "a": "mercury"},
		{"q": "What is the largest organ in the human body?", "a": "skin"}
	]
	
	var idx = (level - 1) % facts.size()
	var f = facts[idx]
	return {
		"question": "🔬 " + f["q"],
		"answer": f["a"].to_lower(),
		"type": "science",
		"difficulty": "medium"
	}

func generate_pattern_puzzle(level: int) -> Dictionary:
	var patterns = [
		{"q": "2, 4, 6, 8, ?", "a": "10"},
		{"q": "1, 4, 9, 16, ?", "a": "25"},
		{"q": "1, 2, 4, 8, ?", "a": "16"},
		{"q": "3, 6, 9, 12, ?", "a": "15"},
		{"q": "5, 10, 15, 20, ?", "a": "25"},
		{"q": "1, 1, 2, 3, 5, 8, ?", "a": "13"},
		{"q": "2, 3, 5, 7, 11, ?", "a": "13"},
		{"q": "10, 20, 30, 40, ?", "a": "50"},
		{"q": "1, 4, 16, 64, ?", "a": "256"},
		{"q": "5, 11, 17, 23, ?", "a": "29"}
	]
	
	var idx = (level - 1) % patterns.size()
	var p = patterns[idx]
	return {
		"question": "🎯 " + p["q"],
		"answer": p["a"],
		"type": "pattern",
		"difficulty": "easy"
	}

func _on_submit_pressed() -> void:
	if not game_active:
		return
	
	var user_answer = answer_input.text.strip_edges().to_lower()
	var correct_answer = current_puzzle["answer"].to_lower()
	
	attempts += 1
	
	if user_answer == correct_answer:
		handle_correct_answer()
	else:
		handle_wrong_answer()

func handle_correct_answer() -> void:
	game_active = false
	
	# Calculate stars
	var earned_stars = 1
	if attempts == 1:
		earned_stars = 3
	elif attempts == 2:
		earned_stars = 2
	
	# Speed bonus
	if time_remaining > 25:
		earned_stars += 1
	
	stars += earned_stars
	streak += 1
	
	# Coin bonus
	var coin_bonus = 5 + (current_level / 10)
	if streak >= 5:
		coin_bonus += 10
	coins += coin_bonus
	
	feedback_label.text = "✅ Correct! +" + str(earned_stars) + "⭐"
	update_ui()
	
	# Next level after delay
	await get_tree().create_timer(1.5).timeout
	current_level += 1
	load_puzzle()

func handle_wrong_answer() -> void:
	streak = 0
	attempts += 1
	
	if attempts >= 3:
		feedback_label.text = "❌ The answer was: " + current_puzzle["answer"]
		game_active = false
		await get_tree().create_timer(2.0).timeout
		current_level += 1
		load_puzzle()
	else:
		feedback_label.text = "❌ Try again! (" + str(3 - attempts) + " attempts left)"

func handle_timeout() -> void:
	game_active = false
	streak = 0
	feedback_label.text = "⏰ Time's up! Answer: " + current_puzzle["answer"]
	await get_tree().create_timer(2.0).timeout
	current_level += 1
	load_puzzle()

func _on_skip_pressed() -> void:
	if game_active:
		current_level += 1
		load_puzzle()

func _on_hint_pressed() -> void:
	if coins >= 25 and game_active:
		coins -= 25
		var answer = current_puzzle["answer"]
		var hint = ""
		if answer.length() > 2:
			hint = "Starts with '" + answer[0] + "', ends with '" + answer[-1] + "'"
		else:
			hint = "Length: " + str(answer.length()) + " characters"
		feedback_label.text = "💡 " + hint
		update_ui()
