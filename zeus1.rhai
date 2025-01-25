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

fn line(v1, v2, type) {
    draw_line(v1[0], v1[1], v2[0], v2[1], type);
}

fn add_point(v1, v2) {
    [v1[0] + v2[0], v1[1] + v2[1]]
}

fn sub_point(v1, v2) {
  [v1[0] - v2[0], v1[1] - v2[1]]
}

fn scale_point(v, scale) {
    [v[0] * scale, v[1] * scale]
}

fn midpoint(v1, v2) {
    [(v1[0] + v2[0]) / 2, (v1[1] + v2[1]) / 2]
}

fn len(v) { sqrt(v[0]*v[0] + v[1]*v[1]); }

fn random_offset(off) {
    let rng = (rand()%100)/100.0;
    [rng * off - off/2.0, rng * off - off/2.0] // Random offset in range [-10, 10]
}

fn fract(v1) { v1 - v1.to_int() }

fn split_and_render(v1, v2, type, iterations) {
    if iterations == 0 {
        line(v1, v2, type);
        return;
    }
    
    let mid = midpoint(v1, v2);
    let l = len(sub_point(v1,v2))/2.0;
    let offset = random_offset(l);
    let displaced_mid = add_point(mid, offset);
    
    split_and_render(v1, displaced_mid, type, iterations - 1);
    split_and_render(displaced_mid, v2, type, iterations - 1);
}

for i in 0..4 {

let v1 = [rand()%1024*1.0, rand()%512];

for j in 0..10 {
let v2 = [v1[0]+rand()%200-100, v1[1] + rand()%200-100];
let type = 60;
let iterations = 5;

if tick % 100 == i*20 {
split_and_render(v1, v2, type, iterations);
}
}
}
