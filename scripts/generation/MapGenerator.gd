extends Node

const MAP_WIDTH = 20
const MAP_HEIGHT = 15

enum TileType {
    WATER = 0,
    GROUND = 1,
    TREE = 2,
    GRASS = 3
}

static func generate_map(tilemap: TileMap):
    var height_map = generate_height_map()
    var tile_types = apply_cellular_automata(height_map)
    draw_tiles(tilemap, tile_types)
    return tile_types

static func generate_height_map():
    var noise = OpenSimplexNoise.new()
    noise.seed = randi()
    noise.octaves = 4
    noise.period = 10.0
    noise.persistence = 0.5
    noise.lacunarity = 2.0
    var map = []
    for y in range(MAP_HEIGHT):
        var row = []
        for x in range(MAP_WIDTH):
            row.append(noise.get_noise_2d(x, y))
        map.append(row)
    return map

static func apply_cellular_automata(height_map):
    var types = []
    for y in range(MAP_HEIGHT):
        var row = []
        for x in range(MAP_WIDTH):
            var val = height_map[y][x]
            if val < -0.3:
                row.append(TileType.WATER)
            elif val > 0.3:
                row.append(TileType.TREE)
            else:
                row.append(TileType.GROUND)
        types.append(row)
    for _iter in range(3):
        types = cellular_automaton_step(types)
    for y in range(MAP_HEIGHT):
        for x in range(MAP_WIDTH):
            if types[y][x] == TileType.GROUND and randf() < 0.3:
                types[y][x] = TileType.GRASS
    return types

static func cellular_automaton_step(grid):
    var new_grid = []
    for y in range(MAP_HEIGHT):
        var row = []
        for x in range(MAP_WIDTH):
            var counts = {}
            for dy in range(-1, 2):
                for dx in range(-1, 2):
                    if dx == 0 and dy == 0:
                        continue
                    var nx = x + dx
                    var ny = y + dy
                    if nx >= 0 and nx < MAP_WIDTH and ny >= 0 and ny < MAP_HEIGHT:
                        var t = grid[ny][nx]
                        counts[t] = counts.get(t, 0) + 1
            var max_count = 0
            var max_type = grid[y][x]
            for t in counts:
                if counts[t] > max_count:
                    max_count = counts[t]
                    max_type = t
            row.append(max_type)
        new_grid.append(row)
    return new_grid

static func draw_tiles(tilemap: TileMap, tile_types):
    tilemap.clear()
    for y in range(MAP_HEIGHT):
        for x in range(MAP_WIDTH):
            tilemap.set_cell(x, y, tile_types[y][x])
    print("Карта сгенерирована! Размер: ", MAP_WIDTH, "x", MAP_HEIGHT)

static func get_tile_cost(tile_type: int) -> int:
    match tile_type:
        TileType.WATER:
            return 99
        TileType.TREE:
            return 99
        _:
            return 1

static func is_walkable(tile_type: int) -> bool:
    return tile_type != TileType.WATER and tile_type != TileType.TREE
