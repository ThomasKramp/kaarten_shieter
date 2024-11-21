// Model
//$fn = 255;
//size = 10;
//height = 10;
//corner_cut(size, height);

// Buck converter body
module corner_cut(length, height) {
    difference() {
        // Main body
        cube([length,length,height]);
        translate([length,length,0]) cylinder(d=length*2,h=height);
    }
}