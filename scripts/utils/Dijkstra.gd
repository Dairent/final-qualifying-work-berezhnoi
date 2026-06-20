class_name Dijkstra

static func calculate_distances(start: Vector2, tile_costs: Dictionary, obstacles: Array) -> Dictionary:
    var distances = {}
    var priority_queue = []
    var visited = {}
    distances[start] = 0
    priority_queue.append({pos = start, dist = 0})
    while priority_queue.size() > 0:
        priority_queue.sort_custom(self, "sort_by_dist")
        var current = priority_queue.pop_front()
        var current_pos = current.pos
        var current_dist = current.dist
        if visited.has(current_pos):
            continue
        visited[current_pos] = true
        for dir in [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]:
            var next_pos = current_pos + dir
            var key = Vector2(round(next_pos.x), round(next_pos.y))
            if visited.has(key):
                continue
            var cost = tile_costs.get(key, 1)
            if cost >= 99:
                continue
            var new_dist = current_dist + cost
            if not distances.has(key) or new_dist < distances[key]:
                distances[key] = new_dist
                priority_queue.append({pos = key, dist = new_dist})
    return distances

static func sort_by_dist(a, b):
    return a.dist < b.dist
