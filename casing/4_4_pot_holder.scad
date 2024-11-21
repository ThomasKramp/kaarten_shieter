
card_holder_h = 21;

p_holder_l = 16;
p_holder_w = 6;
p_holder_h = card_holder_h+p_holder_l;

pot_holder();

module pot_holder() {
    difference() {
        cube([p_holder_l, p_holder_w, p_holder_h]);
        translate([p_holder_w+2,6,card_holder_h+8]) rotate(90,[1,0,0]) cylinder(h=p_holder_w,d=12);
        // Lid grooves
        gr_4_start_w = 19;
            // left
        translate([0, 1.5, 0]) cube([1, 1, 21]);
            // right
        translate([p_holder_l-1, 1.5, 0]) cube([1, 1, 21]);
            // bottom
        translate([0, 0, 0]) cube([p_holder_l, 2.5, 2]);
    }
}