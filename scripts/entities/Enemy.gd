extends Node2D
class_name Enemy

enum Type {
    GOBLIN_WARRIOR,
    GOBLIN_ARCHER,
    SLIME,
    STONE_GOLEM,
    WOLF
}

export(Type) var enemy_type = Type.GOBLIN_WARRIOR
export(int) var hp = 50
export(int) var attack = 10
export(int) var defense = 2
export(int) var move_points = 3
export(int) var initiative = 8

var ai = null
var status_effects = {}

func _ready():
    ai = EnemyAI.new(self)
    var sprite = Sprite.new()
    var rect = RectangleShape2D.new()
    rect.extents = Vector2(16, 16)
    var collision = CollisionShape2D.new()
    collision.shape = rect
    add_child(collision)
    sprite.texture = create_placeholder_texture()
    add_child(sprite)

func create_placeholder_texture() -> ImageTexture:
    var img = Image.new()
    img.create(32, 32, false, Image.FORMAT_RGBA8)
    var color = Color.red
    match enemy_type:
        Type.GOBLIN_WARRIOR:
            color = Color.green
        Type.GOBLIN_ARCHER:
            color = Color.orange
        Type.SLIME:
            color = Color.purple
        Type.STONE_GOLEM:
            color = Color.gray
        Type.WOLF:
            color = Color.brown
    img.fill(color)
    var tex = ImageTexture.new()
    tex.create_from_image(img)
    return tex

func take_turn():
    ai.execute()

func take_damage(dmg: int):
    var actual_dmg = max(0, dmg - defense)
    hp -= actual_dmg
    if hp <= 0:
        die()
    return actual_dmg

func die():
    print("Враг ", enemy_type, " уничтожен!")
    queue_free()

func add_status_effect(effect_name: String, duration: int):
    status_effects[effect_name] = duration

func is_alive() -> bool:
    return hp > 0
