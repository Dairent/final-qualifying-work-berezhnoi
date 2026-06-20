extends Control

var selected_class = ""

func _on_Card_pressed(class_name):
    for child in $HBoxContainer.get_children():
        child.modulate = Color.white
    var card = get_node("HBoxContainer/" + class_name.capitalize() + "Card")
    if card:
        card.modulate = Color.yellow
    selected_class = class_name
    $ConfirmButton.disabled = false

func _on_ConfirmButton_pressed():
    GameManager.selected_class = selected_class
    get_tree().change_scene("res://scenes/BattleScene.tscn")
