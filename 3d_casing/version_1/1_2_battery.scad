// Model
//$fn = 255;
//difference() {
//    bat_d = 18.5;
//    bat_h = 65;
//    battery_body(bat_d, bat_h);
//}

// Battery body
module battery_body(diameter, height) {
    // Main body
    translate([diameter/2,diameter/2,0]) cylinder(d=diameter,h=height);
}