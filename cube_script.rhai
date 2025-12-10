// =========================
// 2D LINE DRAW (Bresenham)
// =========================

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



// =========================
// 3D ROTATION
// =========================

fn rotate_x(p, a) {
    let s = sin(a);
    let c = cos(a);
    [
        p[0],
        p[1] * c - p[2] * s,
        p[1] * s + p[2] * c
    ]
}

fn rotate_y(p, a) {
    let s = sin(a);
    let c = cos(a);
    [
        p[0] * c + p[2] * s,
        p[1],
        -p[0] * s + p[2] * c
    ]
}

fn rotate_z(p, a) {
    let s = sin(a);
    let c = cos(a);
    [
        p[0] * c - p[1] * s,
        p[0] * s + p[1] * c,
        p[2]
    ]
}



// =========================
// 3D → 2D PROJECTION
// =========================

fn project_point(p, cx, cy, scale) {
    let depth = 100.0;
    let factor = scale / (p[2] + depth);
    [
        p[0] * factor + cx,
        p[1] * factor + cy
    ]
}



// =========================
// 3D WIREFRAME CUBE
// =========================

fn spawn_wireframe_cube_3d(cx, cy, size, cell_type, time) {
    let h = size / 2;

    let verts = [
        [-h, -h, -h],
        [ h, -h, -h],
        [ h,  h, -h],
        [-h,  h, -h],

        [-h, -h,  h],
        [ h, -h,  h],
        [ h,  h,  h],
        [-h,  h,  h]
    ];

    let ax = time * 0.7;
    let ay = time * 1.1;
    let az = time * 0.4;

    let rotated = [];
    for v in verts {
        let p = v;
        p = rotate_x(p, ax);
        p = rotate_y(p, ay);
        p = rotate_z(p, az);
        rotated.push(p);
    }

    let projected = [];
    for p in rotated {
        projected.push(project_point(p, cx, cy, size));
    }

    let edges = [
        [0,1],[1,2],[2,3],[3,0],
        [4,5],[5,6],[6,7],[7,4],
        [0,4],[1,5],[2,6],[3,7]
    ];

    for e in edges {
        let a = projected[e[0]];
        let b = projected[e[1]];
        draw_line(a[0], a[1], b[0], b[1], cell_type);
    }
}



// =========================
// CALL
// =========================

spawn_wireframe_cube_3d(150, 150, 80, 60, time);
