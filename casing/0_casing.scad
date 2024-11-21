include <1_0_box.scad>
include <2_0_buck_plate.scad>
include <3_0_pcb_plate.scad>
include <4_0_lid.scad>


$fn = 63;
error = 0.17;
// https://openscad.org/cheatsheet/

box();
translate([8.5, 2, 51.5+error]) buck_plate();
translate([7.75,7.75,67+error]) pcb_plate();
translate([0,0,96]) lid();
translate([-19,39,96]) rotate(270, [0,0,1]) tower();
translate([3,15,96+4]) wheel();
translate([61-2.5+error,33,96]) rotate(270, [0,0,1]) pot_holder();
translate([61-20,18,96+29]) rotate(315, [1,0,0]) pot_arm();