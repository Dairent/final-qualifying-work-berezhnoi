extends Node

var selected_class = null
var current_level = 1
var player_health = 100
var player_max_health = 100
var player_coins = 0
var player_inventory = []
var player_skills_charges = {}

func reset_game():
    selected_class = null
    current_level = 1
    player_health = 100
    player_max_health = 100
    player_coins = 0
    player_inventory = []
    player_skills_charges = {}

func get_class_data(class_name: String):
    var path = "res://assets/resources/hero_classes/" + class_name.capitalize() + ".tres"
    if ResourceLoader.exists(path):
        return load(path)
    return null

func add_coins(amount: int):
    player_coins += amount

func heal_full():
    player_health = player_max_health

func restore_skill_charges():
    player_skills_charges = {
        "Удар щитом": 3,
        "Провокация": 2,
        "Огненный шар": 3,
        "Щит": 2,
        "Двойной выстрел": 3,
        "Уклонение": 2
    }
