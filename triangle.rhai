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

fn rotate_point(x, y, angle) {
    let s = sin(angle);
    let c = cos(angle);
    let nx = (c * x - s * y) + cx;
    let ny = (s * x + c * y) + cy;
    [nx, ny]
}

fn spawn_wireframe_triangle(v1, v2, v3, cell_type) {
    draw_line(v1[0], v1[1], v2[0], v2[1], cell_type);
    draw_line(v2[0], v2[1], v3[0], v3[1], cell_type);
    draw_line(v3[0], v3[1], v1[0], v1[1], cell_type);
}

let x = rand()%1000;
let y = rand()%1000;
let cx = x + 100;
let xy = y + 100;
let cx2 = x - 100;
let cy2 = y - 100;

let v1 = rotate_point(x,y,time);
let v2 = rotate_point(cx,cy,time);
let v3 = rotate_point(cx2,cy2,time);

spawn_wireframe_triangle(v1, v2, v3, 60);
