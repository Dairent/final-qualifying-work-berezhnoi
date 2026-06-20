class_name EnemyAI

var enemy: Enemy
var target = null

func _init(e: Enemy):
    enemy = e
    target = find_target()

func find_target():
    for child in enemy.get_parent().get_children():
        if child is Hero:
            return child
    return null

func execute():
    if target == null:
        return
    var enemy_pos = enemy.position / 32
    var target_pos = target.position / 32
    match enemy.enemy_type:
        Enemy.Type.GOBLIN_WARRIOR, Enemy.Type.WOLF, Enemy.Type.STONE_GOLEM:
            melee_behavior(enemy_pos, target_pos)
        Enemy.Type.GOBLIN_ARCHER:
            ranged_behavior(enemy_pos, target_pos)
        Enemy.Type.SLIME:
            defensive_behavior()

func melee_behavior(enemy_pos: Vector2, target_pos: Vector2):
    var distance = enemy_pos.distance_to(target_pos)
    if distance <= 1.5:
        print("Враг ", enemy.enemy_type, " атакует в ближнем бою!")
        target.take_damage(enemy.attack)
    else:
        print("Враг ", enemy.enemy_type, " двигается к цели")

func ranged_behavior(enemy_pos: Vector2, target_pos: Vector2):
    var distance = enemy_pos.distance_to(target_pos)
    if distance >= 2.0 and distance <= 5.0:
        print("Враг ", enemy.enemy_type, " стреляет!")
        target.take_damage(enemy.attack - 2)
    elif distance > 5.0:
        print("Враг ", enemy.enemy_type, " приближается")
    else:
        print("Враг ", enemy.enemy_type, " отходит")

func defensive_behavior():
    print("Слизь отдыхает и восстанавливает 5 HP")
    enemy.hp = min(enemy.hp + 5, 50)
