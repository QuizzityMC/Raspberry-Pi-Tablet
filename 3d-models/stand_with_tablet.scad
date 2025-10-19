// Show stand with tablet to check proportions
use <stand.scad>
use <assembled_view.scad>

// Show assembled tablet sitting on the stand
translate([40, 40, 72]) // Position tablet on stand lip
rotate([70, 0, 0]) // Tilt to match stand angle  
assembled_tablet();

// Show the stand
tablet_stand();
