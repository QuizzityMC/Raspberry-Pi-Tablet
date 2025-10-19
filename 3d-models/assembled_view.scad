// Assembled View - All parts together
// Shows how the complete Raspberry Pi Tablet looks when assembled

// Include the individual parts
use <bottom_case.scad>
use <top_case.scad>
use <mounting_brackets.scad>

// Assembly parameters
hinge_angle = 110; // Angle between top and bottom cases (degrees)
bracket_offset_from_edge = 20; // Distance from case edge to bracket

// Get dimensions from the individual files
// Bottom case dimensions
rpi5_length = 85;
rpi5_width = 56;
bottom_wall_thickness = 2.5;
bottom_case_tolerance = 0.5;
bottom_case_length = rpi5_length + 2 * bottom_wall_thickness + 2 * bottom_case_tolerance;
bottom_case_width = rpi5_width + 2 * bottom_wall_thickness + 2 * bottom_case_tolerance;
bottom_case_height = 20 + 2.5 + 2; // rpi5_height + base_thickness + 2

// Top case dimensions
display_length = 192.96;
display_width = 110.76;
top_wall_thickness = 2.5;
top_case_tolerance = 0.5;
top_case_length = display_length + 2 * top_wall_thickness + 2 * top_case_tolerance;
top_case_width = display_width + 2 * top_wall_thickness + 2 * top_case_tolerance;
top_case_depth = 6.5 + 3 + 2.5; // display_thickness + front_bezel + wall_thickness

// Bracket dimensions
bracket_length = 50;
bracket_width = 15;
bracket_thickness = 3;

// Calculate hinge pivot point
// The pivot is at the edge where the cases meet
pivot_x = top_case_length / 2;
pivot_y = bracket_offset_from_edge;
pivot_z = bottom_case_height;

module assembled_tablet() {
    // Bottom case (stationary)
    color("lightblue", 0.8)
    bottom_case();
    
    // Bottom brackets (attached to bottom case)
    // Left bracket
    color("green", 0.7)
    translate([bracket_offset_from_edge, -bracket_width/2, bottom_case_height - bracket_thickness])
    rotate([0, 0, 90])
    mounting_bracket();
    
    // Right bracket
    color("green", 0.7)
    translate([bottom_case_length - bracket_offset_from_edge, -bracket_width/2, bottom_case_height - bracket_thickness])
    rotate([0, 0, 90])
    mounting_bracket();
    
    // Top case with brackets (rotated around hinge)
    translate([pivot_x, 0, pivot_z])
    rotate([-hinge_angle, 0, 0])
    translate([-pivot_x, 0, 0]) {
        // Top case
        color("lightblue", 0.8)
        translate([(bottom_case_length - top_case_length)/2, 0, 0])
        rotate([180, 0, 0])
        translate([0, -top_case_width, -top_case_depth])
        top_case();
        
        // Top brackets
        // Left bracket
        color("green", 0.7)
        translate([bracket_offset_from_edge, bracket_width/2, 0])
        rotate([0, 0, -90])
        mounting_bracket();
        
        // Right bracket
        color("green", 0.7)
        translate([bottom_case_length - bracket_offset_from_edge, bracket_width/2, 0])
        rotate([0, 0, -90])
        mounting_bracket();
    }
    
    // Visualize hinge screws (M3)
    color("orange", 0.9) {
        translate([bracket_offset_from_edge, 0, pivot_z])
        rotate([90, 0, 0])
        cylinder(h = 20, d = 3, center = true, $fn = 20);
        
        translate([bottom_case_length - bracket_offset_from_edge, 0, pivot_z])
        rotate([90, 0, 0])
        cylinder(h = 20, d = 3, center = true, $fn = 20);
    }
}

// Render the assembled tablet
assembled_tablet();

// Add text annotation
color("black")
translate([bottom_case_length/2 - 40, -30, 0])
linear_extrude(height = 0.5)
text("Assembled View", size = 6, halign = "center");

color("black")
translate([bottom_case_length/2 - 30, -40, 0])
linear_extrude(height = 0.5)
text(str("Hinge Angle: ", hinge_angle, "°"), size = 5, halign = "center");
