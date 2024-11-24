include <2_1_buck_converter.scad>

$fn = 63;
// https://openscad.org/cheatsheet/

// Wall thickness
case_wt = 2;

// Buck plate start
bc_w = 44;
bc_d = 21.5;
bc_h = 13.5;

// buck_plate();

// Model
module plate(width, depth, offset=[0,0,0]) {
    translate(offset) cube([width,depth,2]);
}

module buck_plate() {
    // Starts at 55.5 mm height
    difference() {
        plate(bc_w, 2*bc_d, [0,0,0]);
        translate([bc_w, 0, case_wt])
        rotate(90, [0,0,1]) buck_body(bc_w, bc_d, bc_h);
        translate([bc_w, bc_d, case_wt])
        rotate(90, [0,0,1]) buck_body(bc_w, bc_d, bc_h);
    }
}