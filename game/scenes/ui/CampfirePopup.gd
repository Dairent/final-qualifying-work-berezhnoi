extends Popup

func _ready():
    update_status()

func update_status():
    $VBoxContainer/StatusLabel.text = "Текущее HP: " + str(GameManager.player_health) + "/" + str(GameManager.player_max_health)

func _on_RestoreButton_pressed():
    GameManager.heal_full()
    GameManager.restore_skill_charges()
    update_status()
    print("Здоровье восстановлено, заряды навыков восстановлены")

func _on_CloseButton_pressed():
    queue_free()
