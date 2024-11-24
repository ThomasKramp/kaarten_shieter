include <0_settings.scad>
include <1_pcb.scad>
include <2_converter.scad>

// Motor
motor_xy = 43+3*error; motor_z = 48+3*error;
cable_x = 16+3*error; cable_y = 12+3*error; cable_z = 9+3*error;
// Battery
bat_xy = 18+3*error; bat_z = 65+3*error;

// Full dimensions add up
    // The width at the motor cable
mc_level_x = cable_x+2*bat_xy+4*wall;
    // The length at the converter plate
conv_level_y = conv_plate_y+bat_xy+wall;

// Casing outer dimensions
case_x = max(pcb_plate_x,conv_plate_x,mc_level_x)+2*wall;
case_y = max(pcb_plate_y,conv_level_y)+2*wall;
case_l1_z = motor_z+wall;
case_l2_z = conv_plate_z+2*wall+error;
case_l3_z = pcb_plate_z+5*wall+error;
case_z = case_l1_z+case_l2_z+case_l3_z;
conrer_rounding = 10;

// Offsets
motor_offset = [(case_x-motor_xy)/2,(case_y-motor_xy)/2,motor_z+wall];
bat_shift = bat_xy+wall;
bat_1_off = [wall, case_y-bat_shift, 2*wall];
bat_2_off = [case_x-bat_shift, case_y-bat_shift, 2*wall];
conv_offset = [(case_x-conv_plate_x)/2,2*wall,wall]+error_offset;
pcbp_offset=[(case_x-pcb_plate_x)/2,wall,wall]+error_offset;


// Case level connector
clc_x = 3; clc_y = 40; clc_z = 5;
clc_1_offset = [wall, (case_y-clc_y)/2,0];
clc_2_offset = [case_x-clc_x-wall, (case_y-clc_y)/2,0];

//box_level_1(show_components);  // Motor
//box_level_2(show_components);  // Converters
//box_level_3(show_components);  // PCB

// Model
module box(show_comp) {
    box_level_1(show_components);  // Motor
    box_level_2(show_components);  // Converters
    box_level_3(show_components);  // PCB
}
module box_level_1(show_comp) {
    // Showcase
    if (show_comp) {
        translate(motor_offset) mirror([0,0,1]) motor();
        translate(bat_1_off) battery_body();
        translate(bat_2_off) battery_body();
    }
    // Cut-out
    difference() {
        round_corner_box([case_x,case_y,case_l1_z], conrer_rounding);
        
        // Bottom corner rounding
        corner_1_offset = [0,0,0];
        translate([0,0,0]) rotate([90,0,90])
        corner_round_cut(conrer_rounding, case_x);
        translate([0,0,0]) rotate([0,270,270])
        corner_round_cut(conrer_rounding, case_y);
        
        corner_2_offset = [0,case_y,0];
        translate(corner_2_offset) rotate([0,270,180])
        corner_round_cut(conrer_rounding, case_x);
        corner_3_offset = [case_x,0,0];
        translate(corner_3_offset) rotate([90,0,180])
        corner_round_cut(conrer_rounding, case_y);
        
        // Motor enclosure
        translate(motor_offset) mirror([0,0,1]) motor();
        
        // Battery enclosure
        translate(bat_1_off) battery_body();
        translate(bat_2_off) battery_body();
    }
    
    // Level connectors
    translate(clc_1_offset+error_offset+[0,0,case_l1_z])
    cube([clc_x-error,clc_y-error,clc_z-error]);
    translate(clc_2_offset+error_offset+[0,0,case_l1_z])
    cube([clc_x-error,clc_y-error,clc_z-error]);
}
module box_level_2(show_comp) {
    // Offsets
    level_2_offset = [0,0,case_l1_z];
    // Showcase
    if (show_plates) {
        translate(conv_offset+level_2_offset) conv_plate(show_comp);
    }
    // Cut-out
    translate(level_2_offset) difference() {
        round_corner_box([case_x,case_y,case_l2_z], conrer_rounding);
        
        // Converter enclosure
        translate(conv_offset) cube([conv_plate_x+error,conv_plate_y+error,case_l2_z+error]);
        
        // Cut-out
        translate(conv_offset+[0,conv_plate_y-error,0]) cube([conv_plate_x+error, bat_xy/2,case_l2_z+error]);
        
        // Level connectors
        translate(clc_1_offset)
        cube([clc_x+error,clc_y+error,clc_z+error]);
        translate(clc_2_offset)
        cube([clc_x+error,clc_y+error,clc_z+error]);
        
        // Previous enclosures
            //Motor
        motor_offset = [(case_x-motor_xy)/2,(case_y-motor_xy)/2,0];
        translate(motor_offset) motor();
        cable_offset = [(motor_xy-cable_x)/2,motor_xy,0];
    translate(motor_offset+cable_offset) cube([cable_x,cable_y,case_l2_z]);
            // Battery
        bat_shift = bat_xy+wall;
        translate([wall, case_y-bat_shift, 0]) battery_body();
        translate([case_x-bat_shift, case_y-bat_shift, 0]) battery_body();
    }
    
    // Level connectors
    translate(clc_1_offset+error_offset+level_2_offset+[0,0,case_l2_z])
    cube([clc_x-error,clc_y-error,clc_z-error]);
    translate(clc_2_offset+error_offset+level_2_offset+[0,0,case_l2_z])
    cube([clc_x-error,clc_y-error,clc_z-error]);
}
module box_level_3(show_comp) {
    // Offsets
    level_3_offset = [0,0,case_l1_z+case_l2_z];
    
    // Showcase
    if (show_plates) {
        translate(pcbp_offset+level_3_offset) pcb_plate(show_comp);
    }
    // Cut-out
    translate(level_3_offset) difference() {
        round_corner_box([case_x,case_y,case_l3_z], conrer_rounding);
        
        // PCB enclosure
        translate(pcbp_offset) cube([pcb_plate_x+error,pcb_plate_y+error,case_l3_z+error]);
        // Port opening
        translate([(case_x-port_x)/2,case_y-wall,2.5*wall]+error_offset) cube([port_x+error,port_y+wall+error,port_z]);
        
        // Cable opening
        cable_y = 12; cable_z = 7;
        translate([0,case_y/1.75,pcb_z/2]) cube([case_x, cable_y, cable_z]);
        
        // Level connectors
        translate(clc_1_offset)
        cube([clc_x+error,clc_y+error,clc_z+error]);
        translate(clc_2_offset)
        cube([clc_x+error,clc_y+error,clc_z+error]);
        
        // Previous enclosures
            //Motor
        motor_offset = [(case_x-motor_xy)/2,(case_y-motor_xy)/2,0];
        translate(motor_offset) motor();
    cable_offset = [(motor_xy-cable_x)/2,motor_xy,0];
    translate(motor_offset+cable_offset) cube([cable_x,cable_y,case_l3_z]);
            // Battery
        bat_shift = bat_xy+wall;
        translate([wall, case_y-bat_shift, 0]) battery_body();
        translate([case_x-bat_shift, case_y-bat_shift, 0]) battery_body();
            // Converter
        translate(conv_offset+[0,0,-wall]) cube([conv_plate_x+error,conv_plate_y+error,case_l3_z+wall+error]);
            // Cut-out
        translate(conv_offset+[0,conv_plate_y-error,-wall]) cube([conv_plate_x+error, bat_xy/2,case_l3_z+wall+error]);
    }
}

module battery_body() {
    // Battery
    translate([bat_xy/2,bat_xy/2,0]) cylinder(d=bat_xy,h=bat_z);
}
module motor() {
    // Corner rounding
    corner_xy = 5-error;
    // Main body
    edge_corner_box([motor_xy,motor_xy,motor_z],corner_xy);
    
    // Cable extensions
    cable_offset = [(motor_xy-cable_x)/2,motor_xy,0];
    translate(cable_offset) cube([cable_x,cable_y,cable_z]);
    
    // Rotary plate
    rp_d = 22+error; rp_h = wall;
    rp_offset = [motor_xy/2,motor_xy/2,motor_z];
    translate(rp_offset) cylinder(d=rp_d,h=rp_h);
    
    // Motor screw holes
    screw_xy = 3+error; screw_h = wall;
    sh_edge_shift = 6+3*error;
            // Right
    screw_1_offset = [sh_edge_shift,sh_edge_shift,motor_z];
    translate(screw_1_offset) cylinder(d=screw_xy,h=screw_h);
    screw_2_offset = [sh_edge_shift,motor_xy-sh_edge_shift,motor_z];
    translate(screw_2_offset) cylinder(d=screw_xy,h=screw_h);
            // Left
    screw_3_offset = [motor_xy-sh_edge_shift,sh_edge_shift,motor_z];
    translate(screw_3_offset) cylinder(d=screw_xy,h=screw_h);
    screw_4_offset = [motor_xy-sh_edge_shift,motor_xy-sh_edge_shift,motor_z];
    translate(screw_4_offset) cylinder(d=screw_xy,h=screw_h);
}