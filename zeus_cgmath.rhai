fn midpoint(v1, v2) {
    vec2((v1.x + v2.x) / 2, (v1.y + v2.y) / 2)
}

fn random_offset(off) {
    let rng = (rand()%100)/100.0;
    vec2(rng * off - off/2.0, rng * off - off/2.0)
}

fn split_and_render(v1, v2, type, iterations) {
    if iterations == 0 {
        draw_line(v1, v2, type);
        return;
    }
    
    let mid = midpoint(v1, v2);
    let l = (v1-v2).magnitude()/2.0;
    let offset = random_offset(l);
    let displaced_mid = mid + offset;
    
    split_and_render(v1, displaced_mid, type, iterations - 1);
    split_and_render(displaced_mid, v2, type, iterations - 1);
}

let type = 60;

let int_x  = rand()%10;
let int_y = rand()%5;
let v1 = vec2(int_x*100.0, int_y*100.0);
if int_y%2 == 0 {
  v1.x += 50;
}

for j in 0..5 {
  let v2 = vec2(v1.x+rand()%200-100, v1.y +   rand()%200-100);

  if true {
   split_and_render(v1, v2, type, 5);
  }
}
