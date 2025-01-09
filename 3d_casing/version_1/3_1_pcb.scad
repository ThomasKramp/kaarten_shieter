//$fn = 63;
//pcb();

module pcb() {
    pcb_w = 45.5;
    pcb_d = 50;
    pcb_h = 5;
    translate([pcb_w-28,0,0]) cube([18.5,6.5,1]);
    translate([0,6.5,0]) cube([pcb_w,43.5,1]);
    translate([3.1,pcb_d-8.4,-2]) cylinder(d=1.5, h=2);
    translate([pcb_w-5.8,pcb_d-8.2,-2]) cylinder(d=1.5, h=2);
}