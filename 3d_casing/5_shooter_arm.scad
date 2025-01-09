include <0_settings.scad>
include <gear_lib.scad> // https://robotix.ah-oui.org/site/main.php?found=200706-basic-gear-lib


// Card motor
cm_x = 20+2*error; cm_y = 20+2*error; cm_z = 15+2*error;
// Card motor holder
cmh_x = cm_x; cmh_y = cm_y+2*wall; cmh_z = cm_z+2*wall;
holder_off = 6;
// Arm
la_y = 40;  // Long arm length
sa_y = 5;   // Short arm length
arm_xz = 7; arm_y = la_y + sa_y; pivot_full_y = arm_y + arm_xz/2;
arm_full_y = pivot_full_y + cmh_y/2;
// Arm hole
ah_d = arm_xz - wall + error; ah_h = arm_xz;
// Arm reinforcement
ar_d = arm_xz + wall; ar_h = arm_xz;
// Card wheel
wheel_d = cmh_y+error; wheel_h = 10+error;
shaft_d = 9+error; shaft_h = 12+error;

//card_wheel();
//union() {
//    translate([cmh_x,pivot_full_y-cmh_x/2,-(cm_y-cm_z)/2]) card_wheel();
//    cm_arm();
//}
module cm_arm() {
    difference() {
        translate([cm_x-arm_xz,0,0]) cm_pivot();
        translate([0,pivot_full_y-cmh_x/2,0]) translate([0, wall, wall]) card_motor();
    }
    translate([0,pivot_full_y-cmh_x/2,0]) cm_holder();
}
module cm_pivot() {
    translate([0,arm_xz/2,0]) difference() {
        union() {
            // Arm
            cube([arm_xz,arm_y,arm_xz]);
            // Arm roundings
            translate([arm_xz/2,0,0]) cylinder(h=ar_h,d=arm_xz);
            // Arm reinforcement
            translate([0,sa_y,(arm_xz-ar_d)/2]) translate([0,ar_d/2,ar_d/2]) 
            rotate(90,[0,1,0]) cylinder(h=ar_h,d=ar_d);
        }
        translate([0,sa_y,(arm_xz-ar_d)/2]) translate([0,ar_d/2,ar_d/2]) 
        rotate(90,[0,1,0]) cylinder(h=ah_h,d=ah_d);
    }
}

module cm_holder() {
    difference() {
        cube([cmh_x, cmh_y, cmh_z]);
        translate([0, wall, wall]) card_motor();
        difference() {
            translate([0,cm_y/2+wall,cm_y/2-wall/2]) rotate(90, [0,1,0]) cylinder(h=cm_x, d=cmh_y*2);
            translate([0,cm_y/2+wall,cm_y/2-wall/2]) rotate(90, [0,1,0]) cylinder(h=cm_x, d=cmh_y);
        }
    }
}
module card_motor() {
    cm_excess = (cm_y-cm_z)/2;
    translate([0,0,-cm_excess]) difference() {
        translate([0,cm_y/2,cm_y/2]) rotate(90, [0,1,0]) cylinder(h=cm_x, d=cm_y);
        translate([0,0,0]) cube([cm_x,cm_y,cm_excess]);
        translate([0,0,cm_excess+cm_z]) cube([cm_x,cm_y,cm_excess]);
    }
}
module card_wheel() {
    difference () {
        translate([0,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=shaft_h, d=shaft_d);
        translate([0,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) gear(8,60,7);
    }
    difference() {
        translate([shaft_h,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=wheel_h, d=wheel_d);
        // Internal wheel
        difference() {
            translate([1.2*shaft_h,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=wheel_h/2, d=wheel_d);
            translate([1.2*shaft_h,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=wheel_h/2, d=wheel_d-2*wall);
        }
    }
}