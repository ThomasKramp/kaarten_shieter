include <0_settings.scad>

// PCB
pcb_x = 45.5+error; pcb_y = 43.5+error; pcb_z = 15+error;
pcb_offset = [0,6.5,0]+error_offset;
// Antenna
ant_x = 18.5+error; ant_y = 6.5+error; ant_z = pcb_z;
ant_offset = [17.5,0,0]+error_offset;
// Mounting holes
hole_d = 1.5-error; hole_h = pcb_z;
hole_1_offset = [3.1,pcb_y-8.4,0]+error_offset;
hole_2_offset = [pcb_x-5.8,pcb_y-8.2,0]+error_offset;
// Charger
charger_x = 18+error; charger_y = 20+error; charger_z = 5+error;
// Port
port_x = 9+error; port_y = 2+error; port_z = 3+error;
// Cable hole
holder_xy = 10+error;

// Full dimensions
pcb_plate_x = max(pcb_x,ant_x,charger_x);
pcb_plate_y = pcb_y+ant_y+charger_y+1.5*holder_xy;
pcb_plate_z = max(pcb_z,ant_z,charger_z);

//pcb_plate(show_components);

module pcb_plate(show_pcb=false) {
    // PCB
    pcb_offset = [0,ant_y,0]+error_offset;
    translate(pcb_offset) cube([pcb_x,pcb_y,plate_h]);
    // Antenna
    ant_offset = [17.5,0,0]+error_offset;
    translate(ant_offset) cube([ant_x,ant_y,plate_h]);
    // Mounting holes
    translate(hole_1_offset) cylinder(d=hole_d, h=hole_h/2);
    translate(hole_2_offset) cylinder(d=hole_d, h=hole_h/2);
    // Cable hole
    holder_1_offset = [0,pcb_y+ant_y,0]+error_offset;
    translate(holder_1_offset) cube([holder_xy,holder_xy,plate_h]);
    holder_2_offset = [pcb_x-holder_xy,pcb_y+ant_y,0]+error_offset;
    translate(holder_2_offset) cube([holder_xy,holder_xy,plate_h]);
    holder_3_offset = [0,pcb_y+ant_y+holder_xy,0]+error_offset;
    translate(holder_3_offset) cube([pcb_x,holder_xy,plate_h]);
    // Charger
    charger_offset = [(pcb_x-charger_x)/2,pcb_y+ant_y+1.5*holder_xy,0]+error_offset;
    translate(charger_offset) difference() {
        cube([charger_x, charger_y, plate_h]);
        translate([0,0,plate_h]) charger();
    }
    if (show_pcb) {
        pcb();
        translate(charger_offset+[0,0,plate_h]) charger();
    }
}

module pcb() {
    difference() {
        union() {
            // PCB
            translate(pcb_offset) cube([pcb_x,pcb_y,pcb_z]);
            // Antenna
            translate(ant_offset) cube([ant_x,ant_y,ant_z]);
        }
        // Mounting holes
        translate(hole_1_offset) cylinder(d=hole_d, h=hole_h);
        translate(hole_2_offset) cylinder(d=hole_d, h=hole_h);
    }
}
module charger() {
    // PCB
    cube([charger_x, charger_y, charger_z]);
    // Port
    port_offset = [(charger_x-port_x)/2,charger_y,(charger_z-port_z)/2];
    translate(port_offset) cube([port_x, port_y, port_z]);
    // Connectors
    conn_xy = 10+error; conn_z=plate_h+error;
    conn_offset = [(charger_x-conn_xy)/2,(charger_y-conn_xy)/2,-conn_z];
    translate(conn_offset) cube([conn_xy,conn_xy,conn_z]);
}