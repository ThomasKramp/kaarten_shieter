//charger(0.5);

module charger(error = 0) {
    cube([18+error, 20+error, 5]);
    translate([4.5,20,1]) cube([9+error, 2+error, 3]);
}