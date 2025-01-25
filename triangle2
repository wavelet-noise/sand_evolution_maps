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

fn rotate_point(x, y, angle) {
    let s = sin(angle);
    let c = cos(angle);
    let nx = c * x - s * y;
    let ny = s * x + c * y;
    [nx, ny]
}

fn spawn_wireframe_triangle(v1, v2, v3, cell_type) {
    draw_line(v1[0], v1[1], v2[0], v2[1], cell_type);
    draw_line(v2[0], v2[1], v3[0], v3[1], cell_type);
    draw_line(v3[0], v3[1], v1[0], v1[1], cell_type);
}

fn add_point(v1, v2) {
  [v1[0] + v2[0], v1[1] + v2[1]]
}

let x = rand()%1024;
let y = rand()%512;
let size = 25 + rand()%75;
let cx = x + size;
let cy = y + size;
let cx2 = x - size;
let cy2 = y + size;

let rand = rand()%100/100.0;

let v1 = rotate_point(x,y,rand);
let v2 = rotate_point(cx,cy,rand);
let v3 = rotate_point(cx2,cy2,rand);

spawn_wireframe_triangle(v1, v2, v3, 60);
