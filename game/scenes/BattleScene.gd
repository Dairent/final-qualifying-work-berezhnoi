extends Node2D

var turn_queue = []
var current_unit_index = 0
var tile_costs = {}
var enemies_defeated = 0
var total_enemies = 0

func _ready():
    print("=== BattleScene запущена ===")
    print("Выбранный класс: ", GameManager.selected_class)
    generate_demo_map()
    add_demo_units()
    total_enemies = $Units.get_child_count() - 1
    print("=== Боевая сцена готова, врагов: ", total_enemies)

func generate_demo_map():
    print("Генерация карты...")
    MapGenerator.generate_map($TileMap)

func add_demo_units():
    var hero = Hero.new()
    hero.position = Vector2(150, 200)
    $Units.add_child(hero)
    
    var enemy_types = [Enemy.Type.GOBLIN_WARRIOR, Enemy.Type.GOBLIN_ARCHER, Enemy.Type.WOLF]
    for i in range(2 + GameManager.current_level):
        var enemy = Enemy.new()
        enemy.enemy_type = enemy_types[randi() % enemy_types.size()]
        enemy.position = Vector2(400 + i*80, 150 + i*30)
        $Units.add_child(enemy)
        enemy.connect("tree_exited", self, "_on_enemy_died")

func _on_enemy_died():
    enemies_defeated += 1
    if enemies_defeated >= total_enemies:
        on_victory()

func on_victory():
    print("Победа!")
    var coins = 5 + GameManager.current_level * 2
    GameManager.add_coins(coins)
    print("Получено монет: ", coins)
    var path_map = load("res://scenes/ui/PathMap.tscn").instance()
    add_child(path_map)
    path_map.set_anchors_and_margins_preset(Control.PRESET_WIDE)

func _on_EndTurnButton_pressed():
    print("Конец хода")
    for child in $Units.get_children():
        if child is Enemy and child.is_alive():
            child.take_turn()
    var enemies_left = 0
    for child in $Units.get_children():
        if child is Enemy and child.is_alive():
            enemies_left += 1
    if enemies_left == 0:
        on_victory()
