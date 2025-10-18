// Top Case for Raspberry Pi Touch Display 2
// Designed to hold the 7" touchscreen display

// Display dimensions (Raspberry Pi Touch Display 2)
display_length = 192.96;
display_width = 110.76;
display_thickness = 6.5; // PCB thickness
screen_length = 155;
screen_width = 86;
screen_offset_x = 19; // Distance from left edge to screen
screen_offset_y = 12; // Distance from top edge to screen

// Display mounting holes (relative to corner)
display_mounting_holes = [
    [4.5, 4.5],
    [4.5, 106.26],
    [188.46, 4.5],
    [188.46, 106.26]
];

// Case parameters
wall_thickness = 2.5;
front_bezel = 3; // Bezel around screen
case_tolerance = 0.5;
corner_radius = 3;

// Mounting post parameters
post_diameter = 6;
post_height = 4;
screw_hole_diameter = 2.2; // For M2.5 screws

// Calculate case dimensions
case_length = display_length + 2 * wall_thickness + 2 * case_tolerance;
case_width = display_width + 2 * wall_thickness + 2 * case_tolerance;
case_depth = display_thickness + front_bezel + wall_thickness;

module rounded_cube(size, radius) {
    hull() {
        for (x = [radius, size[0] - radius]) {
            for (y = [radius, size[1] - radius]) {
                translate([x, y, 0])
                    cylinder(h = size[2], r = radius, $fn = 30);
            }
        }
    }
}

module mounting_post(height, outer_d, inner_d) {
    difference() {
        cylinder(h = height, d = outer_d, $fn = 30);
        translate([0, 0, -0.5])
            cylinder(h = height + 1, d = inner_d, $fn = 20);
    }
}

module top_case() {
    difference() {
        // Main case body
        rounded_cube([case_length, case_width, case_depth], corner_radius);
        
        // Screen cutout
        translate([
            wall_thickness + case_tolerance + screen_offset_x, 
            wall_thickness + case_tolerance + screen_offset_y, 
            -1
        ])
            rounded_cube([screen_length, screen_width, case_depth + 2], 2);
        
        // Display pocket (recessed area for display PCB)
        translate([wall_thickness + case_tolerance, wall_thickness + case_tolerance, front_bezel])
            rounded_cube([
                display_length, 
                display_width, 
                case_depth
            ], corner_radius - wall_thickness);
        
        // Cable access hole (for display cable)
        translate([case_length/2 - 10, case_width - wall_thickness - 1, front_bezel + 2])
            cube([20, wall_thickness + 2, 4]);
    }
    
    // Add mounting posts for display
    for (hole = display_mounting_holes) {
        translate([
            wall_thickness + case_tolerance + hole[0], 
            wall_thickness + case_tolerance + hole[1], 
            front_bezel
        ])
            mounting_post(post_height, post_diameter, screw_hole_diameter);
    }
    
    // Add corner reinforcements
    corner_reinforcement_size = 10;
    corner_reinforcement_height = case_depth - front_bezel - 0.5;
    
    for (x = [0, 1]) {
        for (y = [0, 1]) {
            translate([
                x * (case_length - corner_reinforcement_size - wall_thickness) + wall_thickness,
                y * (case_width - corner_reinforcement_size - wall_thickness) + wall_thickness,
                front_bezel
            ])
            difference() {
                cube([corner_reinforcement_size, corner_reinforcement_size, corner_reinforcement_height]);
                translate([corner_reinforcement_size/2, corner_reinforcement_size/2, -1])
                    cylinder(h = corner_reinforcement_height + 2, d = 3, $fn = 20);
            }
        }
    }
}

// Render the top case
top_case();
