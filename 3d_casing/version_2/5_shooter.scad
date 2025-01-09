include <0_settings.scad>
include <gear_lib.scad> // https://robotix.ah-oui.org/site/main.php?found=200706-basic-gear-lib

// Card motor
cm_x = 20+2*error; cm_y = 25+2*error; cm_z = 15+2*error;
// Card motor holder
cmh_x = cm_x; cmh_y = cm_y+2*wall; cmh_z = cm_z+2*wall;
        holder_off = 6;

// Grooves
gr_x = 2+2*error; gr_y = 2-error; gr_z = cmh_z+2*plate_h+card_deck_h;
gr_1_start_x = gr_x;
gr_2_start_x = gr_1_start_x + 2*gr_x;
gr_3_start_x = gr_2_start_x + 2*gr_x;
gr_4_start_x = gr_3_start_x + 2*gr_x;
// Tower plate
tp_x = 9*gr_x; tp_y = cmh_y+2*(wall+error)+2*wall; tp_z = plate_h;

// Card wheel
wheel_d = cm_x-wall+error; wheel_h = 10+error;
shaft_d = 14+error; shaft_h = 12+error;

// Solinoide
rod_h = 2.5+error; rod_d = 3+error; rod_offset = 5;
soli_xy = 19+error; soli_z = 28+error; soli_x_offset = 2+error;

//card_tower();
//soli_holder();
//translate([0,0,0]) gr_pillar(); // 4 times
//translate([gr_3_start_x,0,0]) gr_pillar();
//translate([2*gr_3_start_x,0,0]) gr_pillar();
//translate([3*gr_3_start_x,0,0]) gr_pillar();
//cm_holder();
//card_wheel();

module card_tower() {
    translate([tp_x,0,0]) union() {
        mirror([1,0,0]) tower();
        translate([6,(tp_y-wheel_d)/2,plate_h]) card_wheel();
    }
}

module tower() {
    tower_bottom();
    translate([gr_x/2,wall,0]) union() {
        gr_pillars();
        translate([0,wall+error,plate_h+error]) cm_holder();
    }
    translate([0,0,gr_z-plate_h]) soli_holder();
}
module tower_bottom() {
    difference() {
        cube([tp_x,tp_y,tp_z]);
        translate([gr_x/2,wall,0]) gr_pillars();
        translate([gr_2_start_x+gr_x/2,2*wall+error+gr_y/2,0]) cube([gr_x,cmh_y-gr_y,plate_h]);
        translate([gr_4_start_x+gr_x/2,2*wall+error+gr_y/2,0]) cube([gr_x,cmh_y-gr_y,plate_h]);
    }
}
module soli_holder() {
    sh_x = soli_xy; sh_y = soli_xy+2*wall; sh_z = soli_z+plate_h;
    difference() {
        // Base plate with pillar holes
        union() {
            translate([0,0,plate_h]) cube([tp_x,tp_y,tp_z]);
            difference() {
                cube([tp_x,tp_y,tp_z]);
                translate([gr_x/2,wall,0]) gr_pillars();
            }
            // Solinoid case
            translate([9*gr_x,(tp_y-sh_y)/2,plate_h]) mirror([1,0,0]) difference() {
                cube([sh_x,sh_y,soli_z]);
                translate([-soli_x_offset,wall,plate_h]) solinoid();
            }
        }
        // Solinoid hole
        translate([9*gr_x,(tp_y-sh_y)/2,plate_h]) mirror([1,0,0])
        translate([-soli_x_offset,wall,plate_h]) solinoid();
        // Remove elastic strips
        translate([gr_2_start_x+gr_x/2,0,0]) cube([gr_x,cmh_y+2*(wall+error)+2*wall,sh_z]);
        translate([gr_4_start_x+gr_x/2,0,0]) cube([gr_x,cmh_y+2*(wall+error)+2*wall,sh_z]);
        
    }
    // Bottom strips
    translate([gr_2_start_x+gr_x/2,2*wall+error+gr_y,0]) cube([gr_x,cmh_y-2*gr_y,plate_h]);
    translate([gr_4_start_x+gr_x/2,2*wall+error+gr_y,0]) cube([gr_x,cmh_y-2*gr_y,plate_h]);
}
module solinoid() {
    // [soli_s,soli_s,tower_h-soli_start_h-tower_wt]
    cube([soli_xy, soli_xy, soli_z]);
    translate([soli_xy/2,soli_xy/2,-(rod_h+rod_offset)]) cylinder(h=rod_h+rod_offset, d=rod_d+error);
}
module gr_pillars() {
    translate([0,0,0]) gr_pillar();
    translate([gr_3_start_x-gr_x,0,0]) gr_pillar();
    translate([0,cmh_y+2*(wall+error),0]) mirror([0,1,0]) gr_pillar();
    translate([gr_3_start_x-gr_x,cmh_y+2*(wall+error),0]) mirror([0,1,0]) gr_pillar();
}
module gr_pillar() {
    cube([3*gr_x,wall,gr_z]);
    translate([gr_x+error,wall,0]) cube([gr_x-2*error,gr_y,gr_z]);
}
module cm_holder() {
    difference() {
        cube([cmh_x, cmh_y, cmh_z]);
        translate([0, wall, wall]) card_motor();
        
        // Groove 1
        translate([gr_1_start_x,0,0]) cube([gr_x, gr_y, gr_z]);
        translate([gr_1_start_x,cmh_y-gr_y,0]) cube([gr_x, gr_y, gr_z]);
        // Groove 2
        translate([gr_2_start_x,0,0]) cube([gr_x, gr_y, gr_z]);
        translate([gr_2_start_x,cmh_y-gr_y,0]) cube([gr_x, gr_y, gr_z]);
        // Groove 3
        translate([gr_3_start_x,0,0]) cube([gr_x, gr_y, gr_z]);
        translate([gr_3_start_x,cmh_y-gr_y,0]) cube([gr_x, gr_y, gr_z]);
        // Groove 4
        translate([gr_4_start_x,0,0]) cube([gr_x, gr_y, gr_z]);
        translate([gr_4_start_x,cmh_y-gr_y,0]) cube([gr_x, gr_y, gr_z]);
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
        translate([0,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) gear(8,60,13);
    }
    difference() {
        translate([shaft_h,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=wheel_h, d=wheel_d);
        difference() {
            translate([1.2*shaft_h,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=wheel_h/2, d=wheel_d);
            translate([1.2*shaft_h,wheel_d/2,wheel_d/2]) rotate(90, [0,1,0]) cylinder(h=wheel_h/2, d=wheel_d-wall);
        }
    }
}