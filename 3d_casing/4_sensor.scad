include <0_settings.scad>

// Potentiometer screw
ps_d = 10+error; ps_h = 5+error;
// Potentiometer holder
ph_x = ps_d+2*wall; ph_y = ps_h; ph_z = ph_x+card_deck_h;

//full_sensor();
//pot_holder();
//pot_arm();

module full_sensor() {
    translate([0,ph_x,0]) rotate(270, [0,0,1]) pot_holder();
    translate([-(23+wall+error),0,card_deck_h+wall+ps_d/2]) rotate(315, [1,0,0]) pot_arm();
}
module pot_holder() {
    difference() {
        cube([ph_x, ph_y, ph_z]);
        translate([ph_x/2,ph_y,card_deck_h+ph_x/2]) rotate(90,[1,0,0]) cylinder(h=ps_h,d=ps_d);
        // Lid grooves
        gr_start_y = (ph_y-wall)/2;
            // left
        translate([0, gr_start_y, 0]) cube([wall, wall, card_deck_h]);
            // right
        translate([ph_x-wall, gr_start_y, 0]) cube([wall, wall, card_deck_h]);
            // bottom
        translate([0, 0, 0]) cube([ph_x, gr_start_y+wall, wall]);
    }
}
module pot_arm() {
    // Potentiometer arm
    arm_x = 7; arm_y = 30; arm_z = 7;
    // Weight hole
    wh_d = 5; wh_h = arm_z;
    difference() {
        union() {
            translate([0,5,5]) rotate(90,[0,1,0]) cylinder(h=14, d=10);
            translate([0,5,3]) cube([arm_x,arm_y,arm_z]);
        }
        translate([4,2,2]) pot_rod();
        translate([arm_x/2,arm_y+1,3]) cylinder(h=wh_h,d=wh_d);
        // corner cutout
        translate([0,arm_y+5,3]) rotate(270, [0,0,1]) corner_round_cut(3.78, arm_z);
        translate([arm_x,arm_y+5,3]) rotate(180, [0,0,1]) corner_round_cut(3.78, arm_z);
    }
}
module pot_rod() {
    // Potentiometer rod
    pr_d = 6; pr_h = 10;
    // Potentiometer rod groove
    prg_x = 2; prg_y = 6; prg_z = 1-0.1;
    // Rod
    difference() {
        translate([0,3,3]) rotate(90,[0,1,0]) cylinder(h=pr_h, d=pr_d);
        translate([0,0,2.45]) cube([prg_x,prg_y,prg_z]);
    }
}
