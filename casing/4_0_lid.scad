include <0_corner_cutout.scad>
include <1_2_battery.scad>
include <4_1_mounts.scad>
include <4_2_card_deck.scad>
include <4_3_shooter_tower.scad>
include <4_3_2_card_wheel.scad>
include <4_4_pot_holder.scad>
include <4_4_1_pot_arm.scad>

$fn = 63;
// https://openscad.org/cheatsheet/

// Casing outer dimensions
case_w = 61;    // width (short side)   49 zonder batterij
case_d = 68;    // depth (long side)    56 zonder batterij

// Wall thickness
case_wt = 2;

lid();
/*translate([-19,39,0]) rotate(270, [0,0,1]) tower();
translate([3,15,4]) wheel();
translate([case_w-2.5+error,33,0]) rotate(270, [0,0,1]) pot_holder();
translate([case_w-20,18,29]) rotate(315, [1,0,0]) pot_arm();*/

// Model
module plate(width, depth, offset=[0,0,0]) {
    translate(offset) cube([width,depth,2]);
}

module lid() {
    difference() {
        card_h = 18.9;
        // Base cube
        cube([case_w,case_d,case_wt+card_h]);
        
        // Space for the cards
        translate([2.5,-23,case_wt]) card();
        
        // Card shooter
        translate([-19,39,0]) rotate(270, [0,0,1]) tower();
        translate([0,12,case_wt]) cube([2.5,25,card_h]);
        
        // Pot holder
        translate([case_w-2.5,33,0]) rotate(270, [0,0,1]) pot_holder();
        
        // Corner rounding
        rounding = 10;
            // x = 0, y = 0
        translate([0,0,0]) corner_cut(rounding, case_wt+card_h);
            // x = 0, y = ?
        translate([0,case_d,0]) rotate(270, [0,0,1]) corner_cut(rounding, case_wt+card_h);
            // x = ?, y = 0
        translate([case_w,0,0]) rotate(90, [0,0,1]) corner_cut(rounding, case_wt+card_h);
            // x = ?, y = ?
        translate([case_w,case_d,0]) rotate(180, [0,0,1]) corner_cut(rounding, case_wt+card_h);
    }
    translate([0,0,-3*case_wt]) mounts();
}