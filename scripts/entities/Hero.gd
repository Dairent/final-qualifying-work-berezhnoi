extends Node2D
class_name Hero

export(int) var max_hp = 100
export(int) var hp = 100
export(int) var attack = 15
export(int) var defense = 5
export(int) var move_points = 4
export(int) var initiative = 10

var items = []
var status_effects = {}

func _ready():
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
    img.fill(Color.blue)
    var tex = ImageTexture.new()
    tex.create_from_image(img)
    return tex

func take_damage(dmg: int):
    var actual_dmg = max(0, dmg - defense)
    hp -= actual_dmg
    if hp <= 0:
        die()
    return actual_dmg

func die():
    print("Герой погиб!")
    queue_free()

func add_status_effect(effect_name: String, duration: int):
    status_effects[effect_name] = duration

func update_status_effects():
    for effect in status_effects.keys():
        status_effects[effect] -= 1
        if status_effects[effect] <= 0:
            status_effects.erase(effect)

func get_available_moves() -> Array:
    return []

func is_alive() -> bool:
    return hp > 0
