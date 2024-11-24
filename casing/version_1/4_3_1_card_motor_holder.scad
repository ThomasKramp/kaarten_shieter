// Card motor
cm_l = 20;
cm_w = 25;
cm_h = 15;

tower_wt = 2;
error = 0.17;

// cm_holder();

module cm_holder () {
    difference() {
        holder_l = cm_l+2*tower_wt;
        holder_h = cm_h+2*tower_wt;
        holder_off = 6;
        translate([0,0,0]) cube([holder_l, cm_w-holder_off, holder_h]);
        translate([tower_wt, 0, tower_wt]) card_motor();
        
        // Grooves
        gr_l = tower_wt-2*error;
        elastic_gr_w = 2+error;
        holder_gr_w = 3+error;
        gr_spacing = 3-error;
        r_gr_start = holder_l - gr_l;
        // 3 wall + 2 elastic + 3 wall + 3 holder + 3 wall + 2 elastic + 3 wall
        
        // Elastic 1 grooves
        gr_start_w_1 = gr_spacing;
             // left 
        translate([0, gr_start_w_1, 0]) cube([gr_l, elastic_gr_w, holder_h]);
            // right
        translate([holder_l-gr_l, gr_start_w_1, 0]) cube([gr_l, elastic_gr_w, holder_h]);
        
        // Holder 1 grooves
        gr_start_w_2 = gr_start_w_1 + elastic_gr_w + gr_spacing;
             // left 
        translate([0, gr_start_w_2, 0]) cube([gr_l, holder_gr_w, holder_h]);
            // right
        translate([holder_l-gr_l, gr_start_w_2, 0]) cube([gr_l, holder_gr_w, holder_h]);
        
        // Elastic 2 grooves
        gr_start_w_3 = gr_start_w_2 + holder_gr_w + gr_spacing;
             // left 
        translate([0, gr_start_w_3, 0]) cube([gr_l, elastic_gr_w, holder_h]);
            // right
        translate([holder_l-gr_l, gr_start_w_3, 0]) cube([gr_l, elastic_gr_w, holder_h]);
    }
    
}

module card_motor() {
    difference() {
        translate([cm_l/2,0,cm_h/2]) rotate(270, [1,0,0]) cylinder(h=cm_w, d=cm_l);
        translate([0,0,-2.5]) cube([cm_l,cm_w,2.5]);
        translate([0,0,cm_h]) cube([cm_l,cm_w,2.5]);
    }
}