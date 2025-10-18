// Stand/Support for Raspberry Pi Tablet
// Allows the tablet to stand at an angle on a desk

// Stand parameters
stand_base_length = 120;
stand_base_width = 80;
stand_base_thickness = 4;
stand_height = 60;
stand_thickness = 4;
stand_angle = 20; // Degrees from vertical

// Lip parameters (to hold tablet)
lip_height = 10;
lip_depth = 8;

// Anti-slip parameters
grip_dot_diameter = 3;
grip_dot_depth = 1;
grip_spacing = 10;

corner_radius = 3;

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

module grip_dots(length, width, dot_d, dot_depth, spacing) {
    for (x = [spacing : spacing : length - spacing]) {
        for (y = [spacing : spacing : width - spacing]) {
            translate([x, y, stand_base_thickness - dot_depth])
                cylinder(h = dot_depth + 0.5, d = dot_d, $fn = 20);
        }
    }
}

module tablet_stand() {
    // Base
    difference() {
        rounded_cube([stand_base_length, stand_base_width, stand_base_thickness], corner_radius);
        
        // Add grip dots to bottom
        translate([corner_radius + 5, corner_radius + 5, 0])
            grip_dots(
                stand_base_length - 2 * corner_radius - 10,
                stand_base_width - 2 * corner_radius - 10,
                grip_dot_diameter,
                grip_dot_depth,
                grip_spacing
            );
    }
    
    // Support arm (angled)
    translate([stand_base_length - stand_thickness, stand_base_width/2 - stand_thickness/2, stand_base_thickness]) {
        rotate([stand_angle, 0, 0]) {
            difference() {
                // Main support
                cube([stand_thickness, stand_thickness, stand_height]);
                
                // Triangular cutout for material savings
                translate([stand_thickness/2, -1, stand_height/2])
                    rotate([-90, 0, 0])
                        cylinder(h = stand_thickness + 2, d = stand_height * 0.6, $fn = 3);
            }
            
            // Lip to hold tablet
            translate([0, 0, stand_height]) {
                cube([stand_thickness, lip_depth, lip_height]);
                
                // Rounded top edge
                translate([stand_thickness/2, lip_depth, lip_height])
                    rotate([0, 90, 0])
                        cylinder(h = stand_thickness, d = 4, center = true, $fn = 30);
            }
        }
    }
    
    // Reinforcement triangle
    translate([stand_base_length - stand_thickness, stand_base_width/2 - stand_thickness/2, stand_base_thickness]) {
        rotate([stand_angle, 0, 0]) {
            // Front reinforcement
            linear_extrude(height = stand_thickness)
                polygon([
                    [0, 0],
                    [0, 20],
                    [-15, 0]
                ]);
        }
    }
}

// Render the stand
tablet_stand();
