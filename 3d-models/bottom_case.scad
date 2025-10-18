// Bottom Case for Raspberry Pi 5
// Designed to hold Raspberry Pi 5 board

// Raspberry Pi 5 dimensions (approximate)
rpi5_length = 85;
rpi5_width = 56;
rpi5_height = 20; // Including components
mounting_hole_diameter = 2.75; // M2.5 screws

// Case parameters
wall_thickness = 2.5;
base_thickness = 2.5;
case_tolerance = 0.5;
corner_radius = 3;

// Mounting post parameters
post_diameter = 6;
post_height = 4;
screw_hole_diameter = 2.2; // For M2.5 screws

// Ventilation parameters
vent_hole_diameter = 3;
vent_hole_spacing = 6;

// Calculate case dimensions
case_length = rpi5_length + 2 * wall_thickness + 2 * case_tolerance;
case_width = rpi5_width + 2 * wall_thickness + 2 * case_tolerance;
case_height = rpi5_height + base_thickness + 2;

// Mounting hole positions (relative to board corner)
// Raspberry Pi 5 mounting holes
mounting_holes = [
    [3.5, 3.5],
    [3.5, 52.5],
    [61.5, 3.5],
    [61.5, 52.5]
];

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

module ventilation_holes(area_length, area_width, hole_d, spacing) {
    for (x = [spacing : spacing : area_length - spacing]) {
        for (y = [spacing : spacing : area_width - spacing]) {
            translate([x, y, -1])
                cylinder(h = base_thickness + 2, d = hole_d, $fn = 20);
        }
    }
}

module bottom_case() {
    difference() {
        // Main case body
        rounded_cube([case_length, case_width, case_height], corner_radius);
        
        // Hollow out the interior
        translate([wall_thickness, wall_thickness, base_thickness])
            rounded_cube([
                case_length - 2 * wall_thickness, 
                case_width - 2 * wall_thickness, 
                case_height
            ], corner_radius - wall_thickness);
        
        // Cutout for ports (USB, HDMI, Ethernet, etc.)
        // USB and Ethernet side
        translate([-1, wall_thickness + case_tolerance + 10, base_thickness + 3])
            cube([wall_thickness + 2, 40, 15]);
        
        // HDMI and Power side
        translate([case_length - wall_thickness - 1, wall_thickness + case_tolerance + 7, base_thickness + 3])
            cube([wall_thickness + 2, 35, 12]);
        
        // SD card slot side
        translate([wall_thickness + case_tolerance + 25, -1, base_thickness + 2])
            cube([20, wall_thickness + 2, 3]);
        
        // Ventilation holes in base
        translate([wall_thickness + 5, wall_thickness + 5, 0])
            ventilation_holes(
                rpi5_length - 10, 
                rpi5_width - 10, 
                vent_hole_diameter, 
                vent_hole_spacing
            );
    }
    
    // Add mounting posts for Raspberry Pi
    for (hole = mounting_holes) {
        translate([
            wall_thickness + case_tolerance + hole[0], 
            wall_thickness + case_tolerance + hole[1], 
            base_thickness
        ])
            mounting_post(post_height, post_diameter, screw_hole_diameter);
    }
}

// Render the bottom case
bottom_case();
