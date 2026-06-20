extends Popup

var items = []

func _ready():
    generate_shop_items()
    update_ui()

func generate_shop_items():
    var possible_items = [
        "res://assets/resources/items/HealthPotion.tres",
        "res://assets/resources/items/StrengthRing.tres",
        "res://assets/resources/items/Amulet.tres",
        "res://assets/resources/items/SpeedBoots.tres"
    ]
    var selected = []
    var pool = possible_items.duplicate()
    for i in range(4):
        if pool.size() == 0:
            break
        var idx = randi() % pool.size()
        var path = pool[idx]
        pool.remove(idx)
        var item = load(path)
        if item:
            selected.append(item)
    items = selected

func update_ui():
    $VBoxContainer/CoinsLabel.text = "Монет: " + str(GameManager.player_coins)
    var container = $VBoxContainer/ItemsContainer
    for child in container.get_children():
        child.queue_free()
    for item in items:
        var btn = Button.new()
        btn.text = item.item_name + " (" + str(item.cost) + " монет)\n" + item.description
        btn.size_flags_horizontal = Control.SIZE_EXPAND
        container.add_child(btn)
        btn.connect("pressed", self, "_on_ItemBuy_pressed", [item])

func _on_ItemBuy_pressed(item):
    if GameManager.player_coins >= item.cost:
        GameManager.player_coins -= item.cost
        GameManager.player_inventory.append(item)
        apply_item_effect(item)
        print("Куплено: ", item.item_name)
        items.erase(item)
        update_ui()
    else:
        print("Недостаточно монет!")

func apply_item_effect(item):
    match item.effect_type:
        "heal":
            GameManager.player_health = min(GameManager.player_health + item.effect_value, GameManager.player_max_health)
        "attack_up":
            pass
        "defense_up":
            pass
        "speed_up":
            pass

func _on_CloseButton_pressed():
    queue_free()
