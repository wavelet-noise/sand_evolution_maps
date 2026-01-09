if tick % 2 != 0 { return }

let cx = GRID_WIDTH.to_float() / 2.0;
let cy = GRID_HEIGHT.to_float() / 2.0;

let t = tick.to_float() / 60.0;
let TAU = 6.283185307179586;

let arms = 16;
let segs = 26;
let step_r = 9.0;
let phase_sel = tick % 2;

let precess = t * 0.22;
let breath = 22.0 * (t * 0.85).sin();

for a in 0..arms {
    if (a % 2) != phase_sel { continue; }
    let arm_phase = a.to_float() * (TAU / arms.to_float());

    let core_type = if a % 3 == 0 { "smoke" } else if a % 3 == 1 { "gas" } else { "fire" };
    let accent_type = if a % 2 == 0 { "fire" } else { "smoke" };

    let prev = vec2(cx, cy);

    for i in 1..=segs {
        let s = i.to_float();

        let ripple = 16.0 * (s * 0.35 - t * 2.0 + arm_phase).sin();
        let r = 18.0 + s * step_r + breath + ripple;

        let swirl = 0.020 * r;
        let wobble = 0.22 * (t * 1.2 + s * 0.25 + arm_phase * 1.7).sin();
        let ang = arm_phase + precess + swirl + wobble;

        let cur = vec2(cx + r * ang.cos(), cy + r * ang.sin());
        let ty = if i % 7 == 0 { accent_type } else { core_type };

        draw_line(prev, cur, ty);
        prev = cur;
    }
}

let comets = 4;
for c in 0..comets {
    let cf = c.to_float();
    let s = (t * 0.9 + cf * 12.345).sin() * 0.5 + 0.5;
    let ang = TAU * s + t * (0.55 + 0.15 * cf);
    let r = 60.0 + 230.0 * (t * 0.25 + cf * 0.17).sin().abs();

    let head = vec2(cx + r * ang.cos(), cy + r * ang.sin());
    let tail = vec2(cx + (r - 90.0) * (ang - 0.35).cos(), cy + (r - 90.0) * (ang - 0.35).sin());

    draw_line(tail, head, "fire");
    set_cell(head, "smoke");
}

let ring_r = 130.0 + 65.0 * (t * 0.8).sin();
let ring_segs = 46;
for i in 0..ring_segs {
    if i % 2 != (tick % 2) { continue; }

    let a0 = (i.to_float() / ring_segs.to_float()) * TAU + precess * 0.5;
    let a1 = ((i + 1).to_float() / ring_segs.to_float()) * TAU + precess * 0.5;

    let r0 = ring_r + 8.0 * (t * 2.5 + a0 * 5.0).sin();
    let r1 = ring_r + 8.0 * (t * 2.5 + a1 * 5.0).sin();

    let p0 = vec2(cx + r0 * a0.cos(), cy + r0 * a0.sin());
    let p1 = vec2(cx + r1 * a1.cos(), cy + r1 * a1.sin());

    draw_line(p0, p1, if i % 3 == 0 { "fire" } else { "smoke" });
}
