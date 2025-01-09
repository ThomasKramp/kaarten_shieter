include <0_settings.scad>
include <6_lid.scad>
include <3_box.scad>

box(show_components);
translate([0,0,case_z]) lid(show_components);