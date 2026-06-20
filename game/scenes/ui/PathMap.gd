extends Control

func _ready():
    $Title.text = "Выберите путь (Уровень " + str(GameManager.current_level) + ", Монет: " + str(GameManager.player_coins) + ")"

func _on_Fight_pressed():
    print("Выбран бой")
    GameManager.current_level += 1
    get_tree().change_scene("res://scenes/BattleScene.tscn")

func _on_Campfire_pressed():
    print("Выбран костёр")
    var campfire = load("res://scenes/ui/CampfirePopup.tscn").instance()
    add_child(campfire)
    campfire.popup_centered()

func _on_Shop_pressed():
    print("Выбран магазин")
    var shop = load("res://scenes/ui/ShopPopup.tscn").instance()
    add_child(shop)
    shop.popup_centered()
