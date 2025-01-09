include <0_corner_cutout.scad>

error = 0.17;

// Card size
card_l = 56+error;
card_w = 87+error;
card_h = 18.9; // 0.3 normally

//card();

module card() {
    difference() {
        // Base card
         cube([card_l, card_w, card_h]);
        
        // Corner rounding
        rounding = 3.78;
            // x = 0, y = 0
        translate([0,0,0]) corner_cut(rounding, card_h);
            // x = 0, y = ?
        translate([0,card_w,0]) rotate(270, [0,0,1]) corner_cut(rounding, card_h);
            // x = ?, y = 0
        translate([card_l,0,0]) rotate(90, [0,0,1]) corner_cut(rounding, card_h);
            // x = ?, y = ?
        translate([card_l,card_w,0]) rotate(180, [0,0,1]) corner_cut(rounding, card_h);
    }
}

module card_deck() {
    for (i = [0 : 54]) {
        translate([0,0,i*card_h]) card();
    }
}