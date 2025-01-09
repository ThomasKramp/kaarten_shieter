include <0_settings.scad>
include <3_box.scad>
include <4_sensor.scad>
include <5_shooter.scad>
include <6_lid_mount.scad>

// Card size
card_x = 56+error; card_y = 87+error; card_z = card_deck_h;
lid_wall = (case_x-card_x)/2;

//lid(show_components);
    

module lid(show_comp) {
    // Showcase
    if (show_comp) {
        translate([case_x-lid_wall,(case_y-ph_x)/2,0]) full_sensor();
        translate([lid_wall-tp_x,(case_y-tp_y)/2,0]) card_tower();
    }
    translate([0,0,-3*wall]) mounts();
    difference() {
        union() {
            // Main body
            round_corner_box([case_x,case_y,plate_h+card_z], conrer_rounding);
            // Card tower plate
        }
        // Cards
        card_offset = [lid_wall,-(card_y-case_y+lid_wall),plate_h];
        translate(card_offset) card();
        // Sensor
        translate([case_x-lid_wall,(case_y-ph_x)/2,0]) full_sensor();
        // Card tower
        translate([lid_wall-tp_x,(case_y-tp_y)/2,0]) union() {
            cube([tp_x,tp_y,card_z+plate_h]);
            card_tower();
        }
    }
    translate([lid_wall,(case_y-tp_y)/2,0]) mirror([1,0,0]) tower_bottom();
    // Tower bottom plate support
    tbp_y = (case_y-tp_y)/2-conrer_rounding;
    translate([0,conrer_rounding+tp_y+tbp_y,0]) rotate(90, [0,0,1]) corner_edge_cut(tp_x-lid_wall,tbp_y,card_z+plate_h);
    translate([0,conrer_rounding+tbp_y,0]) mirror([0,1,0]) rotate(90, [0,0,1]) corner_edge_cut(tp_x-lid_wall,tbp_y,card_z+plate_h);
}

module card() {
    difference() {
        // Base card
         cube([card_x, card_y, card_z]);
        
        // Corner rounding
        rounding = 3.78;
            // x = 0, y = 0
        translate([0,0,0]) rotate(0, [0,0,0])
        corner_round_cut(rounding, card_z);
            // x = 0, y = ?
        translate([0,card_y,0]) rotate(270, [0,0,1])
        corner_round_cut(rounding, card_z);
            // x = ?, y = 0
        translate([card_x,0,0]) rotate(90, [0,0,1])
        corner_round_cut(rounding, card_z);
            // x = ?, y = ?
        translate([card_x,card_y,0]) rotate(180, [0,0,1])
        corner_round_cut(rounding, card_z);
    }
}
module card_deck() {
    for (i = [0 : 54]) {
        translate([0,0,i*card_h]) card();
    }
}