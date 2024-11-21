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
case_h = 98;    // height
error = 0.17;

// Wall thickness
case_wt = 2;

// Motor body dimensions
motor_l = 42 + error;
motor_h = 47.5 + error;
motor_wt = (case_w - motor_l)/2;

// Buck plate start
bc_w = 44;
bc_d = 21.5;
bc_h = 13.5;
bc_slot_start_h = motor_h + 2*case_wt;
bc_slot_wt = (case_w - bc_w)/2;

// Battery
bat_d = 18.5;
bat_h = 65;
bat_shift = bat_d + case_wt;    // for wall at x = ?, y = ?

// PCB
pcb_w = 50;
pcb_d = 45.5;
pcb_h = 5;
pcb_slot_start_h = motor_h + bc_h + 3*case_wt;
pcb_slot_wt = (case_w - pcb_d)/2;

box();

// Model
module box() {
    difference() {
        // Base cube
        cube([case_w,case_d,case_h-case_wt]);
        
        // Corner rounding
        rounding = 10;
            // x = 0, y = 0
        translate([0,0,0]) corner_cut(rounding, case_h);
            // x = 0, y = ?
        translate([0,case_d,0]) rotate(270, [0,0,1]) corner_cut(rounding, case_h);
            // x = ?, y = 0
        translate([case_w,0,0]) rotate(90, [0,0,1]) corner_cut(rounding, case_h);
            // x = ?, y = ?
        translate([case_w,case_d,0]) rotate(180, [0,0,1]) corner_cut(rounding, case_h);
    
        // Motor enclosure
            // Main body wall thickness
            motor_pull = case_h - motor_h;
        translate([motor_wt,case_wt,motor_h+case_wt]) 
        mirror([0,0,1]) motor_body(motor_l, motor_h, motor_pull);
    
        // Battery slot
            bat_pull = case_h - bat_h;
        translate([case_wt, case_d-bat_shift, 2*case_wt]) 
        battery_body(bat_d, bat_h+bat_pull);
        translate([case_w-bat_shift, case_d-bat_shift, 2*case_wt]) 
        battery_body(bat_d, bat_h+bat_pull);
        
        // Buck slot
            bc_w = bc_w + error;
            bc_d = bc_d + error;
            bc_h = bc_h + error;
            bc_slot_start_h = bc_slot_start_h + error;
            bc_slot_wt = (case_w - bc_w)/2;
        translate([bc_slot_wt, case_wt, bc_slot_start_h])
        cube([bc_w, 2*bc_d, bc_slot_start_h]);
        
        // Charger slot
            bat_d = bat_d + error;
            bat_h = bat_h + error;
            bat_shift = bat_d + case_wt;
            // Charger port
        translate([(case_w-18)/2, case_d-22, pcb_slot_start_h-5]) charger(error);
            // Charger slot
        translate([(case_w-18)/2, case_d-22, pcb_slot_start_h-5])
        cube([18, 20, bat_h + 2*case_wt]);
            // Charger connector 2 bat
        translate([(case_w-22)/2, case_d-18, pcb_slot_start_h-3])
        cube([22, 10, bc_slot_start_h]);
        
        // PCB slot
            pcb_w = pcb_w + error;
            pcb_d = pcb_d + error;
            pcb_h = pcb_h + error;
            pcb_slot_start_h = pcb_slot_start_h + error;
            pcb_slot_wt = (case_w - pcb_d)/2;
        translate([pcb_slot_wt, pcb_slot_wt, pcb_slot_start_h])
        cube([pcb_d, pcb_d, bc_slot_start_h]);
        
        // Cable management
        translate([0,19,85]) cube([case_w, 12, 7]);
    }
}