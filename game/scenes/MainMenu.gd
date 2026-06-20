extends Control

func _ready():
    var has_saves = SaveManager.get_save_count() > 0
    $VBoxContainer/Continue.disabled = not has_saves
    $VBoxContainer/Load.disabled = not has_saves

func _on_NewGame_pressed():
    get_tree().change_scene("res://scenes/HeroSelection.tscn")

func _on_Continue_pressed():
    SaveManager.load_last_save()
    get_tree().change_scene("res://scenes/BattleScene.tscn")

func _on_Load_pressed():
    SaveManager.load_save(1)
    get_tree().change_scene("res://scenes/BattleScene.tscn")

func _on_Settings_pressed():
    print("Настройки")

func _on_Quit_pressed():
    get_tree().quit()
