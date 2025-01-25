if tick % 2 != 0 { return }

for j in 0..10 {
    let width = 1024.0;
    let height = 768.0;
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
        draw_line(prev_point, current_point, if j % 2 == 0 {62} else { 2 } );
        prev_point = current_point;
    }
}
