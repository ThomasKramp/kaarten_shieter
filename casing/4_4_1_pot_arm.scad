include <0_corner_cutout.scad>

$fn = 63;

pot_arm();

module pot_arm() {
    arm_l = 30;
    difference() {
        union() {
            translate([0,5,5]) rotate(90,[0,1,0]) cylinder(h=14, d=10);
            translate([0,5,3]) cube([7,arm_l,7]);
        }
        translate([4,2,2]) pot_rod();
        translate([2.5+1,2.5+arm_l-1,3]) cylinder(h=7,d=5);
        // corner cutout
        translate([0,arm_l+5,3]) rotate(270, [0,0,1]) corner_cut(3.78, 7);
        translate([7,arm_l+5,3]) rotate(180, [0,0,1]) corner_cut(3.78, 7);
    }
}

module pot_rod() {
    difference() {
        translate([0,3,3]) rotate(90,[0,1,0]) cylinder(h=10, d=6);
        translate([0,0,2.45]) cube([2,6,1-0.1]);
    }
}