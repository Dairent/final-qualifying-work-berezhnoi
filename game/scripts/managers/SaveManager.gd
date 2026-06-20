extends Node

const SAVE_DIR = "user://saves/"
const META_FILE = "user://saves/save_meta.json"

func _ready():
    var dir = Directory.new()
    if not dir.dir_exists(SAVE_DIR):
        dir.make_dir_recursive(SAVE_DIR)

func get_save_count() -> int:
    var dir = Directory.new()
    if dir.open(SAVE_DIR) == OK:
        dir.list_dir_begin()
        var count = 0
        var file = dir.get_next()
        while file != "":
            if file.ends_with(".json") and file != "save_meta.json":
                count += 1
            file = dir.get_next()
        return count
    return 0

func get_save_list() -> Array:
    var result = []
    var dir = Directory.new()
    if dir.open(SAVE_DIR) == OK:
        dir.list_dir_begin()
        var file = dir.get_next()
        while file != "":
            if file.ends_with(".json") and file != "save_meta.json":
                result.append(file)
            file = dir.get_next()
    return result

func load_last_save():
    var saves = get_save_list()
    if saves.size() > 0:
        load_save_file(SAVE_DIR + saves[-1])
    else:
        print("Нет сохранений")

func load_save(slot: int):
    var saves = get_save_list()
    if slot <= saves.size():
        load_save_file(SAVE_DIR + saves[slot-1])

func load_save_file(path: String):
    var file = File.new()
    if file.file_exists(path):
        file.open(path, File.READ)
        var data = parse_json(file.get_as_text())
        file.close()
        if data:
            restore_game_state(data)
        else:
            print("Ошибка загрузки: неверный формат")

func restore_game_state(data: Dictionary):
    if data.has("selected_class"):
        GameManager.selected_class = data["selected_class"]
    if data.has("current_level"):
        GameManager.current_level = data["current_level"]
    if data.has("player_health"):
        GameManager.player_health = data["player_health"]
    if data.has("player_coins"):
        GameManager.player_coins = data["player_coins"]

func save_game(slot: int, data: Dictionary):
    var path = SAVE_DIR + "save_slot_" + str(slot) + ".json"
    var file = File.new()
    file.open(path, File.WRITE)
    file.store_string(JSON.print(data, true))
    file.close()
    update_meta_file(slot, data)

func update_meta_file(slot: int, data: Dictionary):
    var meta = {}
    var file = File.new()
    if file.file_exists(META_FILE):
        file.open(META_FILE, File.READ)
        meta = parse_json(file.get_as_text())
        file.close()
    if meta == null:
        meta = {}
    meta[str(slot)] = {
        "date": OS.get_datetime(),
        "level": data.get("current_level", 1),
        "class": data.get("selected_class", "unknown")
    }
    file.open(META_FILE, File.WRITE)
    file.store_string(JSON.print(meta, true))
    file.close()
