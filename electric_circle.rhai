if tick % 3 != 0 { return }

let cx = GRID_WIDTH.to_float() / 2.0;
let cy = GRID_HEIGHT.to_float() / 2.0;
let segments = 48;
let TAU = 6.283185307179586;
let t = tick.to_float() / 60.0;

let sun_radius = 12.0;
let prev_sun = vec2(cx + sun_radius, cy);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(cx + sun_radius * angle.cos(), cy + sun_radius * angle.sin());
    draw_line(prev_sun, cur, "fire");
    prev_sun = cur;
}

let orbit1_radius = 50.0;
let planet1_speed = 0.8;
let planet1_angle = t * planet1_speed;
let planet1_depth = planet1_angle.cos() * 0.3 + 0.7;
let planet1_x = cx + orbit1_radius * planet1_angle.cos();
let planet1_y = cy + orbit1_radius * planet1_angle.sin();
let planet1_radius_val = 6.0 * planet1_depth;
let planet1_type = if planet1_depth > 0.7 { "electricity" } else { "plasma" };
let prev1 = vec2(planet1_x + planet1_radius_val, planet1_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(planet1_x + planet1_radius_val * angle.cos(), planet1_y + planet1_radius_val * angle.sin());
    draw_line(prev1, cur, planet1_type);
    prev1 = cur;
}

let moon1_orbit = 12.0;
let moon1_speed = planet1_speed * 3.0;
let moon1_angle = t * moon1_speed + planet1_angle;
let moon1_x = planet1_x + moon1_orbit * moon1_angle.cos();
let moon1_y = planet1_y + moon1_orbit * moon1_angle.sin();
let prev_moon1 = vec2(moon1_x + 2.0, moon1_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(moon1_x + 2.0 * angle.cos(), moon1_y + 2.0 * angle.sin());
    draw_line(prev_moon1, cur, "electricity");
    prev_moon1 = cur;
}

let moon2_orbit = 12.0;
let moon2_speed = planet1_speed * 2.5;
let moon2_angle = t * moon2_speed + planet1_angle + TAU / 3.0;
let moon2_x = planet1_x + moon2_orbit * moon2_angle.cos();
let moon2_y = planet1_y + moon2_orbit * moon2_angle.sin();
let prev_moon2 = vec2(moon2_x + 2.0, moon2_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(moon2_x + 2.0 * angle.cos(), moon2_y + 2.0 * angle.sin());
    draw_line(prev_moon2, cur, "plasma");
    prev_moon2 = cur;
}

let orbit2_radius = 90.0;
let planet2_speed = 0.5;
let planet2_angle = t * planet2_speed + TAU / 4.0;
let planet2_depth = planet2_angle.cos() * 0.3 + 0.7;
let planet2_x = cx + orbit2_radius * planet2_angle.cos();
let planet2_y = cy + orbit2_radius * planet2_angle.sin();
let planet2_radius_val = 7.0 * planet2_depth;
let planet2_type = if planet2_depth > 0.7 { "electricity" } else { "plasma" };
let prev2 = vec2(planet2_x + planet2_radius_val, planet2_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(planet2_x + planet2_radius_val * angle.cos(), planet2_y + planet2_radius_val * angle.sin());
    draw_line(prev2, cur, planet2_type);
    prev2 = cur;
}

let moon3_orbit = 15.0;
let moon3_speed = planet2_speed * 4.0;
let moon3_angle = t * moon3_speed + planet2_angle;
let moon3_x = planet2_x + moon3_orbit * moon3_angle.cos();
let moon3_y = planet2_y + moon3_orbit * moon3_angle.sin();
let prev_moon3 = vec2(moon3_x + 2.5, moon3_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(moon3_x + 2.5 * angle.cos(), moon3_y + 2.5 * angle.sin());
    draw_line(prev_moon3, cur, "electricity");
    prev_moon3 = cur;
}

let orbit3_radius = 140.0;
let planet3_speed = 0.35;
let planet3_angle = t * planet3_speed + TAU / 2.0;
let planet3_depth = planet3_angle.cos() * 0.3 + 0.7;
let planet3_x = cx + orbit3_radius * planet3_angle.cos();
let planet3_y = cy + orbit3_radius * planet3_angle.sin();
let planet3_radius_val = 8.0 * planet3_depth;
let planet3_type = if planet3_depth > 0.7 { "electricity" } else { "plasma" };
let prev3 = vec2(planet3_x + planet3_radius_val, planet3_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(planet3_x + planet3_radius_val * angle.cos(), planet3_y + planet3_radius_val * angle.sin());
    draw_line(prev3, cur, planet3_type);
    prev3 = cur;
}

let moon4_orbit = 18.0;
let moon4_speed = planet3_speed * 3.5;
let moon4_angle = t * moon4_speed + planet3_angle;
let moon4_x = planet3_x + moon4_orbit * moon4_angle.cos();
let moon4_y = planet3_y + moon4_orbit * moon4_angle.sin();
let prev_moon4 = vec2(moon4_x + 3.0, moon4_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(moon4_x + 3.0 * angle.cos(), moon4_y + 3.0 * angle.sin());
    draw_line(prev_moon4, cur, "electricity");
    prev_moon4 = cur;
}

let moon5_orbit = 18.0;
let moon5_speed = planet3_speed * 2.8;
let moon5_angle = t * moon5_speed + planet3_angle + TAU / 2.0;
let moon5_x = planet3_x + moon5_orbit * moon5_angle.cos();
let moon5_y = planet3_y + moon5_orbit * moon5_angle.sin();
let prev_moon5 = vec2(moon5_x + 2.5, moon5_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(moon5_x + 2.5 * angle.cos(), moon5_y + 2.5 * angle.sin());
    draw_line(prev_moon5, cur, "plasma");
    prev_moon5 = cur;
}

let orbit4_radius = 190.0;
let planet4_speed = 0.25;
let planet4_angle = t * planet4_speed + TAU / 3.0;
let planet4_depth = planet4_angle.cos() * 0.3 + 0.7;
let planet4_x = cx + orbit4_radius * planet4_angle.cos();
let planet4_y = cy + orbit4_radius * planet4_angle.sin();
let planet4_radius_val = 9.0 * planet4_depth;
let planet4_type = if planet4_depth > 0.7 { "electricity" } else { "plasma" };
let prev4 = vec2(planet4_x + planet4_radius_val, planet4_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(planet4_x + planet4_radius_val * angle.cos(), planet4_y + planet4_radius_val * angle.sin());
    draw_line(prev4, cur, planet4_type);
    prev4 = cur;
}

let moon6_orbit = 20.0;
let moon6_speed = planet4_speed * 4.5;
let moon6_angle = t * moon6_speed + planet4_angle;
let moon6_x = planet4_x + moon6_orbit * moon6_angle.cos();
let moon6_y = planet4_y + moon6_orbit * moon6_angle.sin();
let prev_moon6 = vec2(moon6_x + 3.0, moon6_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(moon6_x + 3.0 * angle.cos(), moon6_y + 3.0 * angle.sin());
    draw_line(prev_moon6, cur, "electricity");
    prev_moon6 = cur;
}

let moon7_orbit = 20.0;
let moon7_speed = planet4_speed * 3.2;
let moon7_angle = t * moon7_speed + planet4_angle + TAU / 3.0;
let moon7_x = planet4_x + moon7_orbit * moon7_angle.cos();
let moon7_y = planet4_y + moon7_orbit * moon7_angle.sin();
let prev_moon7 = vec2(moon7_x + 2.5, moon7_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(moon7_x + 2.5 * angle.cos(), moon7_y + 2.5 * angle.sin());
    draw_line(prev_moon7, cur, "plasma");
    prev_moon7 = cur;
}

let moon8_orbit = 20.0;
let moon8_speed = planet4_speed * 2.5;
let moon8_angle = t * moon8_speed + planet4_angle + TAU * 2.0 / 3.0;
let moon8_x = planet4_x + moon8_orbit * moon8_angle.cos();
let moon8_y = planet4_y + moon8_orbit * moon8_angle.sin();
let prev_moon8 = vec2(moon8_x + 2.0, moon8_y);
for i in 1..=segments {
    let angle = (i.to_float() / segments.to_float()) * TAU;
    let cur = vec2(moon8_x + 2.0 * angle.cos(), moon8_y + 2.0 * angle.sin());
    draw_line(prev_moon8, cur, "electricity");
    prev_moon8 = cur;
}

