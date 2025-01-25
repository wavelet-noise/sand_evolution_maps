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

fn rotate_point(v, angle) {
  let s = sin(angle);
  let c = cos(angle);
  [v[0]*c - v[0]*s, v[0]*s + v[1]*c]
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

let type = 61;

for i in 0..50 {
let v = [4*i*(sin(i.to_float()+2.32+sin(time)*0.1)),1*i];

v = add_point(rotate_point(v, time - i), [512.0,256.0]);

set_cell(v[0].to_int(), v[1].to_int(), type)
}
