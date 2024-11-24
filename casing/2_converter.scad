include <0_settings.scad>

// Step up converter
suc_x = 36+error; suc_y = 17+error; suc_z = 19+error;
// Step down converter
sdc_x = 43.5+error; sdc_y = 21+error; sdc_z = 14+error;
// Converter cables
cc_x = 4+error; cc_y = 3+error;

// Full dimensions
conv_plate_x = max(suc_x,sdc_x)+2*cc_x;
conv_plate_y = suc_y+2*sdc_y+2*wall;
conv_plate_z = max(suc_z,sdc_z);

//conv_plate(show_components);

module conv_plate(show_conv=false) {
    plate_x = sdc_x+2*cc_x; plate_y = suc_y+2*sdc_y+2*wall;
    suc_offset = [(sdc_x-suc_x)/2,0,plate_h];
    sdc_1_offset = [0,suc_y+wall,plate_h];
    sdc_2_offset = [0,suc_y+sdc_y+2*wall,plate_h];
    difference() {
        // Plate
        cube([plate_x,plate_y,plate_h*2]);
        // Step up converter
        translate(suc_offset) step_up_converter();
        // Step down converter
        translate(sdc_1_offset) step_down_converter();
        translate(sdc_2_offset) step_down_converter();
    }
    if (show_conv) {
        translate(suc_offset) step_up_converter();
        translate(sdc_1_offset) step_down_converter();
        translate(sdc_2_offset) step_down_converter();
    }
}

module step_up_converter() {
    // Step up converter
    translate([cc_x,0,0]) cube([suc_x,suc_y,suc_z]);
    // Cables
        // Right
    cable_1_offset = [0,0,0];
    translate(cable_1_offset) cube([cc_x,cc_y,suc_z]);
    cable_2_offset = [0,suc_y-cc_y,0];
    translate(cable_2_offset) cube([cc_x,cc_y,suc_z]);
        // Left
    cable_3_offset = [suc_x+cc_x,0,0];
    translate(cable_3_offset) cube([cc_x,cc_y,suc_z]);
    cable_4_offset = [suc_x+cc_x,suc_y-cc_y,0];
    translate(cable_4_offset) cube([cc_x,cc_y,suc_z]);
}
module step_down_converter() {
    translate([cc_x,0,0]) difference() {
        // Step down converter
        cube([sdc_x,sdc_y,sdc_z]);
    
        // Mounting holes
        hole_d = 3.5-error; hole_h = sdc_z;
        hole_1_offset = [sdc_x-6.5,2.5,0]+error_offset;
        hole_2_offset = [6.5,sdc_y-2.5,0]+error_offset;
        translate(hole_1_offset) cylinder(d=hole_d,h=hole_h);
        translate(hole_2_offset) cylinder(d=hole_d,h=hole_h);
    }
    // Cables
        // Right
    cable_1_offset = [0,0,0];
    translate(cable_1_offset) cube([cc_x,cc_y,sdc_z]);
    cable_2_offset = [0,sdc_y-cc_y,0];
    translate(cable_2_offset) cube([cc_x,cc_y,sdc_z]);
        // Left
    cable_3_offset = [sdc_x+cc_x,0,0];
    translate(cable_3_offset) cube([cc_x,cc_y,sdc_z]);
    cable_4_offset = [sdc_x+cc_x,sdc_y-cc_y,0];
    translate(cable_4_offset) cube([cc_x,cc_y,sdc_z]);
}