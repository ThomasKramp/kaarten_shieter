// Model
//$fn = 255;
//difference() {
//    bc_w = 21.5;
//    bc_d = 44;
//    bc_h = 13.5;
//    buck_body(bc_w, bc_d, bc_h);
//}

// Buck converter body
module buck_body(width, depth, height) {
    // Main body
    cube([width,depth,height]);
    
    // Motor screw holes
    sh_size = 3.5;
    sh_h = 2;
    translate([2.5,11,-sh_h]) cylinder(d=sh_size,h=sh_h);
    translate([19,32.5,-sh_h]) cylinder(d=sh_size,h=sh_h);
}