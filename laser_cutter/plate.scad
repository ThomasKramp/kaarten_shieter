$fn = 63;

plate_x = 100; plate_y = 100; plate_z = 2;
kerf = 0.1;
hole_d = 4.9-2*kerf; hole_h = plate_z;
chip_x = 0.5+kerf; chip_y = hole_d; chip_z = hole_h;
kerf = 0.1;


projection() difference() {
    // Plate
    translate([-plate_x/2, -plate_y/2, 0])
    cube([plate_x, plate_y, plate_z]);
    
    // Hole
    difference() {
        cylinder(h=hole_h, d=hole_d);
        translate([hole_d/2-chip_x, -chip_y/2, 0])
        cube([chip_x, chip_y, chip_z]);
    }
}