include <0_corner_cutout.scad>
include <1_1_motor.scad>
include <1_2_battery.scad>
include <1_3_charger.scad>
include <2_1_buck_converter.scad>
include <3_1_pcb.scad>

$fn = 63;
// https://openscad.org/cheatsheet/

// Casing outer dimensions
case_w = 61;    // width (short side)   49 zonder batterij
case_d = 68;    // depth (long side)    56 zonder batterij

// Wall thickness
case_wt = 2;

// Battery
bat_d = 18.5;
bat_h = 65;
bat_shift = bat_d + case_wt;    // for wall at x = ?, y = ?

// PCB
pcb_w = 50;
pcb_d = 45.5;
pcb_h = 5;
pcb_slot_wt = (case_w - pcb_d)/2;

pcb_plate();

// Model
module plate(width, depth, offset=[0,0,0]) {
    translate(offset) cube([width,depth,2]);
}

module pcb_plate() {
    // Starts at 71 mm height
    difference() {
        plate(pcb_d, pcb_w+case_wt, [0,0,0]);
        translate([0,-pcb_slot_wt,case_wt]) pcb();
        // Bat holes
        translate([case_wt-pcb_slot_wt, case_d-bat_shift-pcb_slot_wt, 0]) 
        battery_body(bat_d, case_wt);
        translate([case_w-bat_shift-pcb_slot_wt, case_d-bat_shift-pcb_slot_wt, 0]) 
        battery_body(bat_d, case_wt);
    }
}