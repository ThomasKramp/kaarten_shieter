include <0_settings.scad>
include <1_pcb.scad>
include <2_converter.scad>
include <3_box.scad>

//mounts();

module mounts() {
    // Fit in case
        // Battery 1
    difference() {
        battery1();
        battery1(2);    // Battery 1 hole
        cut_out(2);     // Cut-out
        pcb(2);         // Remove PCB square
    }
    // Battery 2
    difference() {
        battery2();
        battery2(2);    // Battery 2 hole
        cut_out(2);     // Cut-out
        pcb(2);         // Remove PCB square
    }
        // Converter
    difference() {
        conv();
        conv(2);        // Converter hole
        cut_out(2);     // Cut-out
        pcb(2);         // Remove PCB square
    }
        // Cut-out
    difference() {
        cut_out();
        cut_out(2);     // Cut-out
        battery1(2);    // Battery 1 hole
        battery2(2);    // Battery 2 hole
        conv(2);        // Converter hole
        pcb(2);         // Remove PCB square
    }
        // PCB
    difference() {
        pcb();
        pcb(2);         // PCB hole
        battery1(2);    // Battery 1 hole
        battery2(2);    // Battery 2 hole
        conv(2);        // Converter hole
        cut_out(2);     // Cut-out
    }
}

module battery1(hole=0) {
    translate([bat_xy/2,bat_xy/2,0])
    translate(bat_1_off-[0,0,2*wall])
    cylinder(d=bat_xy-2*hole-error,h=3*wall);
}
module battery2(hole=0) {
    translate([bat_xy/2,bat_xy/2,0])
    translate(bat_2_off-[0,0,2*wall])
    cylinder(d=bat_xy-2*hole-error,h=3*wall);
}
module conv(hole=0) {
    translate(conv_offset+[hole,hole,-wall]+error_offset)
    cube([conv_plate_x-2*hole-error,conv_plate_y-2*hole-error, 3*wall]);
}
module cut_out(hole=0) {
    translate(conv_offset+[error/2,conv_plate_y-error,0]+[hole,hole,-wall])
    cube([conv_plate_x-2*hole-error,bat_xy/2-2*hole-error,3*wall]);
}
module pcb(hole=0) {
    translate(pcbp_offset+[hole,hole,-wall]+error_offset)
    cube([pcb_plate_x-2*hole-error,pcb_plate_y-2*hole-error,3*wall]);
}