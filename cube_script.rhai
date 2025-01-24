fn draw_line(x1, y1, x2, y2, cell_type) {
    let dx = abs(x2 - x1);
    let dy = abs(y2 - y1);
    let sx = if x1 < x2 { 1 } else { -1 };
    let sy = if y1 < y2 { 1 } else { -1 };
    let mut_err = dx - dy;
    let mut_x = x1;
    let mut_y = y1;
    let max_iterations = max(dx, dy) + 1; // Ensure the loop terminates by limiting iterations
    for _ in 0..max_iterations {
        set_cell(mut_x.to_int(), mut_y.to_int(), cell_type);
        if mut_x == x2 && mut_y == y2 { break; }
        let e2 = 2 * mut_err;
        if e2 > -dy {
            mut_err -= dy;
            mut_x += sx;
        }
        if e2 < dx {
            mut_err += dx;
            mut_y += sy;
        }
    }
}

fn rotate_point(x, y, cx, cy, angle) {
    let s = sin(angle);
    let c = cos(angle);
    let nx = (c * (x - cx) - s * (y - cy)) + cx;
    let ny = (s * (x - cx) + c * (y - cy)) + cy;
    [nx, ny]
}

fn spawn_wireframe_triangle(v1, v2, v3, cell_type) {
    draw_line(v1[0], v1[1], v2[0], v2[1], cell_type);
    draw_line(v2[0], v2[1], v3[0], v3[1], cell_type);
    draw_line(v3[0], v3[1], v1[0], v1[1], cell_type);
}

fn spawn_wireframe_cube(base_x, base_y, size, cell_type, time) {
    let angle = time;
    let cx = base_x + size / 2;
    let cy = base_y + size / 2;
    let v1 = rotate_point(base_x, base_y, cx, cy, angle);
    let v2 = rotate_point(base_x + size, base_y, cx, cy, angle);
    let v3 = rotate_point(base_x + size, base_y + size, cx, cy, angle);
    let v4 = rotate_point(base_x, base_y + size, cx, cy, angle);
    let v5 = rotate_point(base_x + size / 2, base_y - size / 2, cx, cy, angle);
    let v6 = rotate_point(base_x + size + size / 2, base_y - size / 2, cx, cy, angle);
    let v7 = rotate_point(base_x + size + size / 2, base_y + size - size / 2, cx, cy, angle);
    let v8 = rotate_point(base_x + size / 2, base_y + size - size / 2, cx, cy, angle);
    spawn_wireframe_triangle(v1, v2, v3, cell_type);
    spawn_wireframe_triangle(v1, v3, v4, cell_type);
    spawn_wireframe_triangle(v5, v6, v7, cell_type);
    spawn_wireframe_triangle(v5, v7, v8, cell_type);
    draw_line(v1[0], v1[1], v5[0], v5[1], cell_type);
    draw_line(v2[0], v2[1], v6[0], v6[1], cell_type);
    draw_line(v3[0], v3[1], v7[0], v7[1], cell_type);
    draw_line(v4[0], v4[1], v8[0], v8[1], cell_type);
}

spawn_wireframe_cube(100, 100, 50, 60, time);
