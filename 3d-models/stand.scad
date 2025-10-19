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

// Cutout parameters
support_cutout_ratio = 0.6; // Ratio of support height for triangular cutout

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
                cylinder(h = dot_depth + 1, d = dot_d, $fn = 20);
        }
    }
}

module tablet_stand() {
    union() {
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
        
        // Support arm assembly (angled)  
        translate([stand_base_length - stand_thickness, stand_base_width/2 - stand_thickness/2, stand_base_thickness]) {
            // Main support structure with integrated base connection
            hull() {
                // Base connection - extends slightly into base for good union
                translate([0, 0, -0.5])
                    cube([stand_thickness, stand_thickness, 1]);
                
                // Base of rotated support
                rotate([stand_angle, 0, 0])
                    cube([stand_thickness, stand_thickness, 1]);
            }
            
            // Main support structure
            rotate([stand_angle, 0, 0]) {
                union() {
                    // Main vertical support
                    cube([stand_thickness, stand_thickness, stand_height]);
                    
                    // Lip to hold tablet with rounded top
                    hull() {
                        translate([0, 0, stand_height])
                            cube([stand_thickness, lip_depth, lip_height]);
                        
                        // Rounded top edge for comfort
                        translate([0, lip_depth, stand_height + lip_height])
                            rotate([0, 90, 0])
                                cylinder(h = stand_thickness, r = 2, $fn = 30);
                    }
                    
                    // Reinforcement wedge - integrated properly
                    hull() {
                        // Bottom front
                        translate([0, 0, 0])
                            cube([stand_thickness, stand_thickness, 0.1]);
                        
                        // Mid-height front
                        translate([0, 0, 20])
                            cube([stand_thickness, stand_thickness, 0.1]);
                        
                        // Back bottom
                        translate([-15, 0, 0])
                            cube([stand_thickness, stand_thickness, 0.1]);
                    }
                }
            }
        }
    }
}

// Render the stand
tablet_stand();
