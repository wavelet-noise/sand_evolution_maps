fn draw_line(x1, y1, x2, y2, cell_type) {
    let dx = abs(x2 - x1);
    let dy = abs(y2 - y1);
    let sx = if x1 < x2 { 1 } else { -1 };
    let sy = if y1 < y2 { 1 } else { -1 };
    let err = dx - dy;
    let x = x1;
    let y = y1;
    let max_iterations = max(dx.to_int(), dy.to_int()) + 1; 
    for i in 0..max_iterations {
        set_cell(x.to_int(), y.to_int(), cell_type);
        if x == x2 && y == y2 { break; }
        let e2 = 2 * err;
        if e2 > -dy {
            err -= dy;
            x += sx;
        }
        if e2 < dx {
            err += dx;
            y += sy;
        }
    }
}

if tick % 2 != 0 { return }

for j in 0..10 {
    let width = GRID_WIDTH.to_float();
    let height = GRID_HEIGHT.to_float();
    let center_x = width / 2.0;
    let center_y = height / 2.0;
    let amplitude = 50.0;
    let frequency = 2.0; 
    let off = j * 40 -300;

    let segments = 8;

    let step = width / segments.to_float();
    let prev_point = vec2(0.0, center_y + off);

    for i in 1..=segments {
        let x = i.to_float() * step;
        let y = center_y + amplitude * (frequency * (x / width) * 2.0 * 3.1416 + time + j/2.0).sin();
        let current_point = vec2(x, y + off);
        draw_line(prev_point.x, prev_point.y, current_point.x, current_point.y, if j % 2 == 0 {62} else { 2 } );
        prev_point = current_point;
    }
}
