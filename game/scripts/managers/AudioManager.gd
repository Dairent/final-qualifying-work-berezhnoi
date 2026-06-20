extends Node

var music_bus = null
var sfx_bus = null

func _ready():
    if AudioServer.get_bus_index("Music") == -1:
        AudioServer.add_bus()
        AudioServer.set_bus_name(AudioServer.get_bus_count()-1, "Music")
    if AudioServer.get_bus_index("SFX") == -1:
        AudioServer.add_bus()
        AudioServer.set_bus_name(AudioServer.get_bus_count()-1, "SFX")
    music_bus = AudioServer.get_bus_index("Music")
    sfx_bus = AudioServer.get_bus_index("SFX")

func set_music_volume(value: float):
    if music_bus != null:
        AudioServer.set_bus_volume_db(music_bus, value)

func set_sfx_volume(value: float):
    if sfx_bus != null:
        AudioServer.set_bus_volume_db(sfx_bus, value)

func play_sfx(sound: String):
    print("Воспроизведение звука: ", sound)

func play_music(music: String):
    print("Воспроизведение музыки: ", music)
