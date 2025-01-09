include <gear_lib.scad> // https://robotix.ah-oui.org/site/main.php?found=200706-basic-gear-lib
$fn = 63;

wheel_d = 19;
wheel_h = 6;
shaft_d = 6;
shaft_h = 12;

// wheel();

module wheel() {
    difference () {
        translate([0,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=shaft_h, d=shaft_d);
        translate([0,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) gear(8,50,5);
    }
    difference() {
        translate([shaft_h,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=wheel_h, d=wheel_d);
        difference() {
            translate([shaft_h+2,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=2, d=wheel_d);
            translate([shaft_h+2,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=2, d=wheel_d-1);
        }
    }
}