class_name AStar

static func find_path(start: Vector2, goal: Vector2, walkable_cells: Array) -> Array:
    var astar = AStar2D.new()
    var points = {}
    for cell in walkable_cells:
        var key = int(cell.x * 1000 + cell.y)
        astar.add_point(key, cell)
        points[key] = cell
    for key in points:
        var pos = points[key]
        var neighbors = [
            pos + Vector2(1, 0),
            pos + Vector2(-1, 0),
            pos + Vector2(0, 1),
            pos + Vector2(0, -1)
        ]
        for n in neighbors:
            var n_key = int(n.x * 1000 + n.y)
            if points.has(n_key):
                if not astar.are_points_connected(key, n_key):
                    astar.connect_points(key, n_key)
    var start_key = int(round(start.x) * 1000 + round(start.y))
    var goal_key = int(round(goal.x) * 1000 + round(goal.y))
    if astar.has_point(start_key) and astar.has_point(goal_key):
        return astar.get_point_path(start_key, goal_key)
    else:
        return []
