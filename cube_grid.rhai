if tick % 3 != 0 { return }

fn draw_line(x1, y1, x2, y2, cell_type) {
    let dx = abs(x2 - x1);
    let dy = abs(y2 - y1);
    let sx = if x1 < x2 { 1 } else { -1 };
    let sy = if y1 < y2 { 1 } else { -1 };
    let mut_err = dx - dy;
    let mut_x = x1;
    let mut_y = y1;
    let max_iterations = (max(dx, dy) + 1).to_int(); 

    for ff in 0..max_iterations {
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

fn draw_square(cx, cy, size, cell_type) {
    let half = size / 2.0;
    let x1 = (cx - half).to_int();
    let y1 = (cy - half).to_int();
    let x2 = (cx + half).to_int();
    let y2 = (cy + half).to_int();
    
    for x in x1..=x2 {
        set_cell(x, y1, cell_type);
        set_cell(x, y2, cell_type);
    }
    
    for y in y1..=y2 {
        set_cell(x1, y, cell_type);
        set_cell(x2, y, cell_type);
    }
}

fn rotate_point_2d(cx, cy, px, py, angle) {
    let s = sin(angle);
    let c = cos(angle);
    let dx = px - cx;
    let dy = py - cy;
    [
        dx * c - dy * s + cx,
        dx * s + dy * c + cy
    ]
}

fn square_with_children(cx, cy, size, cell_type, child_size_ratio, child_cell_type, angle_offset) {
    let half = size / 2.0;
    
    draw_square(cx, cy, size, cell_type);
    
    let vertices = [
        [cx - half, cy - half],
        [cx + half, cy - half],
        [cx + half, cy + half],
        [cx - half, cy + half]
    ];
    
    let child_size = size * child_size_ratio;
    for v in vertices {
        let rotated = rotate_point_2d(cx, cy, v[0], v[1], angle_offset);
        draw_square(rotated[0], rotated[1], child_size, child_cell_type);
    }
}

fn square_with_rotating_children(cx, cy, size, cell_type, child_size_ratio, base_rotation_speed, level, max_level, time) {
    if level > max_level { return; }
    
    let current_cell_type = if level % 3 == 0 { "laser" } else if level % 3 == 1 { "electricity" } else { "plasma" };
    
    let speed_multiplier = 1.0 + level.to_float() * 0.8;
    let current_rotation_speed = base_rotation_speed * speed_multiplier;
    let parent_angle = time * current_rotation_speed;
    
    let self_rotation_speed = 1.5 + level.to_float() * 0.5;
    let self_angle = time * self_rotation_speed;
    
    let phase_offset = level.to_float() * 0.7;
    let pulse_frequency = 1.5 + level.to_float() * 0.3;
    let scale_factor = 0.6 + 0.4 * sin(time * pulse_frequency + phase_offset);
    let scaled_size = size * scale_factor;
    
    if scale_factor > 0.95 {
        let fire_count = 3 + level;
        let fire_spacing = scaled_size * 0.15;
        for i in 0..fire_count {
            let angle_offset = (i.to_float() / fire_count.to_float()) * 6.28318;
            let fire_x = cx + cos(angle_offset + time * 2.0) * fire_spacing;
            let fire_y = cy + sin(angle_offset + time * 2.0) * fire_spacing;
            let fire_size = scaled_size * 0.08;
            draw_square(fire_x, fire_y, fire_size, "fire");
        }
    }
    
    let half = scaled_size / 2.0;
    
    let base_vertices = [
        [cx - half, cy - half],
        [cx + half, cy - half],
        [cx + half, cy + half],
        [cx - half, cy + half]
    ];
    
    let rotated_vertices = [];
    for v in base_vertices {
        rotated_vertices.push(rotate_point_2d(cx, cy, v[0], v[1], parent_angle));
    }
    
    let self_rotated_vertices = [];
    for v in rotated_vertices {
        self_rotated_vertices.push(rotate_point_2d(cx, cy, v[0], v[1], self_angle));
    }
    
    for i in 0..4 {
        let v1 = self_rotated_vertices[i];
        let v2 = self_rotated_vertices[(i + 1) % 4];
        draw_line(v1[0], v1[1], v2[0], v2[1], current_cell_type);
    }
    
    if level < max_level {
        let child_size = scaled_size * child_size_ratio;
        let orbital_offset = scaled_size * 0.15 * sin(time * 2.0 + level.to_float());
        
        for i in 0..4 {
            let v = rotated_vertices[i];
            let dir_angle = parent_angle + i.to_float() * 1.5708;
            let offset_x = cos(dir_angle + 1.5708) * orbital_offset;
            let offset_y = sin(dir_angle + 1.5708) * orbital_offset;
            let child_pos = [v[0] + offset_x, v[1] + offset_y];
            
            square_with_rotating_children(child_pos[0], child_pos[1], child_size, current_cell_type, child_size_ratio, base_rotation_speed, level + 1, max_level, time);
        }
    }
}

let center_x = GRID_WIDTH.to_float() / 2.0;
let center_y = GRID_HEIGHT.to_float() / 2.0;

let main_size = 200.0;
let base_rotation_speed = 0.4;
square_with_rotating_children(center_x, center_y, main_size, "laser", 0.35, base_rotation_speed, 0, 3, time);

