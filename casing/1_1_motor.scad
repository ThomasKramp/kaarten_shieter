include <0_corner_cutout.scad>

// Model
//$fn = 63;
//motor_l = 42;   motor_h = 47.5;   pull = 3;
//motor_body(motor_l, motor_h);
//translate([0,0,motor_h]) mirror([0,0,1]) motor_body(motor_l, motor_h, pull);

// Motor body
module motor_body(length,height,height_pull=0) {
    height = height + height_pull;
    difference() {
        // Main body
        translate([0,0,-height_pull]) 
        cube([length,length,height]);
    
        // Corner rounding
        rounding = 7;
        translate([0,0,-height_pull]) corner_cut(rounding, height);
        translate([0, motor_l,-height_pull]) 
        rotate(270, [0,0,1]) corner_cut(rounding, height);
        translate([motor_l,0,-height_pull]) 
        rotate(90, [0,0,1]) corner_cut(rounding, height);
        translate([motor_l,motor_l,-height_pull]) 
        rotate(180, [0,0,1]) corner_cut(rounding, height);
    }
    
    // Cable extensions
        cable_w = 16;
        cable_d = 10;
        cable_h = 9 + height_pull;
    cable_shift = (length - cable_w)/2;
    translate([cable_shift,length,-height_pull]) cube([cable_w,cable_d,cable_h]);
    
    // Rotary plate
        rotary_base_d = 22; // diameter
        rotary_base_h = 2;  // height
    translate([length/2,length/2,height-height_pull]) cylinder(d=rotary_base_d,h=rotary_base_h);
    
    // Motor screw holes
    sh_size = 3;
    sh_edge_shift = 5.5;
    translate([sh_edge_shift,sh_edge_shift,height-height_pull]) cylinder(d=sh_size,h=rotary_base_h);
    translate([length-sh_edge_shift,sh_edge_shift,height-height_pull]) cylinder(d=sh_size,h=rotary_base_h);
    translate([sh_edge_shift,length-sh_edge_shift,height-height_pull]) cylinder(d=sh_size,h=rotary_base_h);
    translate([length-sh_edge_shift,length-sh_edge_shift,height-height_pull]) cylinder(d=sh_size,h=rotary_base_h);
}