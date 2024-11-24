include <1_2_battery.scad>

$fn = 63;
// https://openscad.org/cheatsheet/

// Casing outer dimensions
case_w = 61;    // width (short side)   49 zonder batterij
case_d = 68;    // depth (long side)    56 zonder batterij

// Wall thickness
case_wt = 2;

// Buck plate start
bc_w = 44;
bc_d = 21.5;
bc_slot_wt = (case_w - bc_w)/2;

// Battery
bat_d = 18.5;
bat_shift = bat_d + case_wt;    // for wall at x = ?, y = ?

// PCB
pcb_w = 50;
pcb_d = 45.5;
pcb_slot_wt = (case_w - pcb_d)/2;

//mounts();

module mounts() {
    // Fit in case
        // Battery 1
    difference() {
        battery1();
        battery1(2);    // Battery 1 hole
        bat2char();     // Charger connector hole
        pcb(2);         // Remove PCB square
    }
    // Battery 2
    difference() {
        battery2();
        battery2(2);    // Battery 2 hole
        bat2char();     // Charger connector hole
        pcb(2);         // Remove PCB square
    }
        // Buck
    difference() {
        buck();
        buck(2);        // Buck hole
        pcb(2);         // Remove PCB square
    }
        // Charger
    difference() {
        charger();
        charger(2);     // Charger hole
        bat2char(2);    // Charger connector hole
        pcb(2);         // Remove PCB square
    }
    // Charger connector 2 bat
    difference() {
        bat2char();
        bat2char(2);    // Charger connector hole
        battery1(2);    // Battery 1 hole
        battery2(2);    // Battery 2 hole
        charger(2);     // Remove Charger hole
        pcb(2);         // Remove PCB square
    }
        // PCB
    difference() {
        pcb();
        pcb(2);         // PCB hole
        battery1(2);    // Battery 1 hole
        battery2(2);    // Battery 2 hole
        buck(2);        // Buck hole
        charger(2);     // Charger hole
        bat2char();     // Charger connector hole
    }
}

module battery1(hole=0) {
    translate([case_wt+hole, case_d-bat_shift+hole, 0]) battery_body(bat_d-2*hole, 3*case_wt);
}
module battery2(hole=0) {
    translate([case_w-bat_shift+hole, case_d-bat_shift+hole, 0]) battery_body(bat_d-2*hole, 3*case_wt);
}
module buck(hole=0) {
    translate([bc_slot_wt+hole, case_wt+hole, 0]) cube([bc_w-2*hole, 2*bc_d-2*hole, 3*case_wt]);
}
module charger(hole=0) {
    translate([(case_w-18)/2+hole, case_d-22+hole, 0]) cube([18-2*hole, 20-2*hole, 3*case_wt]);
}
module bat2char(hole=0) {
    translate([(case_w-36)/2+hole, case_d-24+hole, 0]) cube([36-2*hole, 16-2*hole, 3*case_wt]);
}
module pcb(hole=0) {
    translate([pcb_slot_wt+hole, pcb_slot_wt+hole, 0]) cube([pcb_d-2*hole, pcb_d-2*hole, 3*case_wt]);
}