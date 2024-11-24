include <4_3_1_card_motor_holder.scad>

$fn = 63;

// Card motor
cm_l = 20;
cm_w = 25;
cm_h = 15;
card_deck_h = 18.9;

// Solinoide
rod_h = 2.5; rod_d = 3; rod_off = 5;
soli_s = 19;
soli_h = 28 + rod_off; // + card_deck_h
soli_off = 2;

// Tower
tower_l = 29;
tower_w = soli_s+2.5;
tower_wt = 2;
tower_h = card_deck_h + cm_h + soli_h + 3*tower_wt+1;

// Components starting points
soli_start_h = tower_h - soli_h - tower_wt;

error = 0.17;

//solinoide();
// tower();

module tower() {
    cm_holder_h = card_deck_h+cm_h;
    gr_w = 3-error;
    center_soli = (tower_l - soli_s)/2;
    difference() {
        translate([0,0,0]) cube([tower_l,tower_w,tower_h]);
        
        // Card motor holder
        translate([tower_wt,0,tower_wt]) cube([tower_l-2*tower_wt,tower_w,cm_holder_h]);
        
        // Solinoide holder
        translate([center_soli,-2,soli_start_h]) solinoide();
        
        // Elastic grooves
        gr_1_start_w = 2.5;
            // left
        translate([0, gr_1_start_w, 0]) cube([tower_wt, gr_w, tower_h]);
            // right
        translate([tower_l-tower_wt, gr_1_start_w, 0]) cube([tower_wt, gr_w, tower_h]);
            // bottom
        translate([0, gr_1_start_w, 0]) cube([tower_l, gr_w, tower_wt]);
        gr_3_start_w = 13.5;
            // left
        translate([0, gr_3_start_w, 0]) cube([tower_wt, gr_w, tower_h]);
            // right
        translate([tower_l-tower_wt, gr_3_start_w, 0]) cube([tower_wt, gr_w, tower_h]);
            // bottom
        translate([0, gr_3_start_w, 0]) cube([tower_l, gr_w, tower_wt]);
        
        // Lid grooves
        gr_4_start_w = 19;
            // left
        translate([0, gr_4_start_w, 0]) cube([1, 1, 21]);
            // right
        translate([tower_l-1, gr_4_start_w, 0]) cube([1, 1, 21]);
            // bottom
        translate([0, gr_4_start_w, 0]) cube([tower_l, 2.5, tower_wt]);
    }
    // Card motor holder
    translate([tower_wt+0.5, 0, 2*tower_wt]) cm_holder();
    // Card motor holder groove
    gr_2_start_w = 8+error;
        // left
    translate([tower_wt, gr_2_start_w, tower_wt]) cube([tower_wt, gr_w, cm_holder_h]);
        // right
    translate([tower_l-2*tower_wt, gr_2_start_w, tower_wt]) cube([tower_wt, gr_w, cm_holder_h]);
    
    // Shaft
    translate([center_soli+soli_s/2,soli_s/2-2,soli_start_h-rod_off]) cylinder(h=rod_h+rod_off, d=rod_d-error);
    translate([center_soli+soli_s/2,soli_s/2-2,soli_start_h+2]) cylinder(h=1, d=2*rod_d);
    translate([center_soli+soli_s/2,soli_s/2-2,soli_start_h-rod_off-1]) cylinder(h=1, d=2*rod_d);
}

//translate([0, tower_wt, soli_start_h]) solinoide();
module solinoide() {
    // [soli_s,soli_s,tower_h-soli_start_h-tower_wt]
    cube([soli_s, soli_s, soli_h]);
    translate([soli_s/2,soli_s/2,-rod_h]) cylinder(h=rod_h+rod_off, d=rod_d+error);
    translate([soli_s/2,soli_s/2,soli_h]) cylinder(h=rod_h+rod_off, d=rod_d+error);
    
    // Mounting holes
    mh_d = 3;
    translate([0,3.5,rod_off+4]) rotate(270,[0,1,0]) cylinder(h=rod_h+rod_off, d=mh_d);
    translate([0,soli_s-3.5,soli_h-4.5]) rotate(270,[0,1,0]) cylinder(h=rod_h+rod_off, d=mh_d);
    translate([soli_s,soli_s-3.5,rod_off+7.5]) rotate(90,[0,1,0]) cylinder(h=rod_h+rod_off, d=mh_d);
    translate([soli_s,3.5,soli_h-5.5]) rotate(90,[0,1,0]) cylinder(h=rod_h+rod_off, d=mh_d);
}