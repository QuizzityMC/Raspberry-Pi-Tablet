use <stand.scad>
use <assembled_view.scad>

// Show the stand
color("blue", 0.7)
tablet_stand();

// Show the assembled tablet next to it  
translate([150, 0, 0])
assembled_tablet();
