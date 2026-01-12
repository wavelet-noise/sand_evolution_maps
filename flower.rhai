// ---- Line draw (Bresenham) ----

fn draw_line(x1, y1, x2, y2, cell_type) {
    let dx = abs(x2 - x1);
    let dy = abs(y2 - y1);
    let sx = if x1 < x2 { 1 } else { -1 };
    let sy = if y1 < y2 { 1 } else { -1 };
    let mut_err = dx - dy;
    let mut_x = x1;
    let mut_y = y1;
    let max_iterations = (max(dx, dy) + 1).to_int();

    for i in 0..max_iterations {
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


// ---- Flower shape ----

fn draw_flower(cx, cy, base_r, petals, cell_type, time, speed) {
    let PI = 3.14159265;
    let steps = 180;

    let prev_x = 0.0;
    let prev_y = 0.0;
    let has_prev = false;

    for i in 0..steps {
        let t = i.to_float() / steps.to_float();
        let ang = t * 2.0 * PI;

        let r = base_r * (0.6 + 0.3 * sin(petals.to_float() * ang + time * speed));

        let x = cx + r * cos(ang);
        let y = cy + r * sin(ang);

        if has_prev {
            draw_line(prev_x, prev_y, x, y, cell_type);
        }

        prev_x = x;
        prev_y = y;
        has_prev = true;
    }
}


// ---- Rays around flower ----

fn draw_rays(cx, cy, inner_r, outer_r, count, cell_type, time) {
    let PI = 3.14159265;

    for i in 0..count {
        let t = i.to_float() / count.to_float();
        let ang = t * 2.0 * PI + time * 0.5;

        let wobble = 1.0 + 0.15 * sin(time * 1.3 + i.to_float() * 0.7);
        let r1 = inner_r * wobble;
        let r2 = outer_r * wobble;

        let x1 = cx + r1 * cos(ang);
        let y1 = cy + r1 * sin(ang);
        let x2 = cx + r2 * cos(ang);
        let y2 = cy + r2 * sin(ang);

        draw_line(x1, y1, x2, y2, cell_type);
    }
}


// ---- Main pattern ----

fn spawn_flower_pattern(cx, cy, cell_type, time) {
    draw_flower(cx, cy, 70.0, 6, cell_type,     time, 1.2);
    draw_flower(cx, cy, 40.0, 9, cell_type + 1, time*2, 2.0);
    draw_flower(cx, cy, 95.0, 4, cell_type + 2, -time, 0.7);
    draw_rays(cx, cy, 25.0, 30.0, 18, cell_type, -time/2);
}


spawn_flower_pattern(GRID_WIDTH.to_float() / 2.0, GRID_HEIGHT.to_float() / 2.0, 60, time);
