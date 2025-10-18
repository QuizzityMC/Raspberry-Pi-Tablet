// Hinge/Mounting Brackets for connecting top and bottom cases
// Creates 4 brackets (2 left side, 2 right side) to allow adjustable angle

// Bracket parameters
bracket_length = 50;
bracket_width = 15;
bracket_thickness = 3;
hinge_hole_diameter = 3.5; // For M3 screw
mounting_hole_diameter = 2.2; // For M2.5 screw
corner_radius = 2;

// Hole positions
hinge_hole_offset = 10; // From one end
mounting_hole_offset = 10; // From other end

module rounded_rectangle(length, width, thickness, radius) {
    hull() {
        for (x = [radius, length - radius]) {
            for (y = [radius, width - radius]) {
                translate([x, y, 0])
                    cylinder(h = thickness, r = radius, $fn = 30);
            }
        }
    }
}

module mounting_bracket() {
    difference() {
        // Main bracket body
        rounded_rectangle(bracket_length, bracket_width, bracket_thickness, corner_radius);
        
        // Hinge hole (larger, for rotation)
        translate([hinge_hole_offset, bracket_width/2, -0.5])
            cylinder(h = bracket_thickness + 1, d = hinge_hole_diameter, $fn = 30);
        
        // Mounting hole
        translate([bracket_length - mounting_hole_offset, bracket_width/2, -0.5])
            cylinder(h = bracket_thickness + 1, d = mounting_hole_diameter, $fn = 30);
    }
}

// Render 4 brackets in a layout for printing
spacing = 20;

// Left side brackets (2 pieces)
translate([0, 0, 0])
    mounting_bracket();

translate([0, bracket_width + spacing, 0])
    mounting_bracket();

// Right side brackets (2 pieces)
translate([bracket_length + spacing, 0, 0])
    mounting_bracket();

translate([bracket_length + spacing, bracket_width + spacing, 0])
    mounting_bracket();

// Add text labels (optional, can be commented out)
translate([bracket_length/2 - 10, -5, 0])
    linear_extrude(height = 0.5)
        text("L1", size = 4, halign = "center");

translate([bracket_length/2 - 10, bracket_width + spacing - 5, 0])
    linear_extrude(height = 0.5)
        text("L2", size = 4, halign = "center");

translate([bracket_length + spacing + bracket_length/2 - 10, -5, 0])
    linear_extrude(height = 0.5)
        text("R1", size = 4, halign = "center");

translate([bracket_length + spacing + bracket_length/2 - 10, bracket_width + spacing - 5, 0])
    linear_extrude(height = 0.5)
        text("R2", size = 4, halign = "center");
