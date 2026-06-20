class_name CellularAutomata

static func apply(grid: Array, iterations: int = 3) -> Array:
    var result = grid.duplicate(true)
    for _iter in range(iterations):
        result = step(result)
    return result

static func step(grid: Array) -> Array:
    var new_grid = []
    var height = grid.size()
    var width = grid[0].size() if height > 0 else 0
    for y in range(height):
        var row = []
        for x in range(width):
            var counts = {}
            for dy in range(-1, 2):
                for dx in range(-1, 2):
                    if dx == 0 and dy == 0:
                        continue
                    var nx = x + dx
                    var ny = y + dy
                    if nx >= 0 and nx < width and ny >= 0 and ny < height:
                        var val = grid[ny][nx]
                        counts[val] = counts.get(val, 0) + 1
            var max_count = 0
            var max_type = grid[y][x]
            for t in counts:
                if counts[t] > max_count:
                    max_count = counts[t]
                    max_type = t
            row.append(max_type)
        new_grid.append(row)
    return new_grid
