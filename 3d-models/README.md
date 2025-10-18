# 3D Printed Case for Raspberry Pi Tablet

This directory contains 3D printer files for creating a custom case for a Raspberry Pi tablet using:
- **Raspberry Pi 5**
- **Raspberry Pi Touch Display 2** (7" touchscreen)

## Files Included

### OpenSCAD Source Files (.scad)
These are parametric 3D models that can be customized and exported to STL format:

1. **bottom_case.scad** - Bottom case that houses the Raspberry Pi 5
2. **top_case.scad** - Top case that holds the touchscreen display
3. **mounting_brackets.scad** - Brackets to connect the top and bottom cases (creates 4 pieces)
4. **stand.scad** - Optional stand for desktop use

### Features

#### Bottom Case
- Designed to fit Raspberry Pi 5 (85mm × 56mm)
- Mounting posts for secure board attachment
- Port cutouts for:
  - USB ports
  - Ethernet port
  - HDMI ports
  - Power connector
  - SD card slot
- Ventilation holes for cooling
- Wall thickness: 2.5mm for durability

#### Top Case
- Designed for Raspberry Pi Touch Display 2 (192.96mm × 110.76mm)
- Screen cutout (155mm × 86mm viewable area)
- Mounting posts for display PCB
- Bezel around screen for protection
- Cable access hole for display cable
- Corner reinforcements for strength

#### Mounting Brackets
- 4 brackets (2 per side) to connect cases
- Allows adjustable viewing angle
- Uses M3 screws for hinges
- Uses M2.5 screws for mounting

#### Stand
- Desktop stand for angled viewing
- Anti-slip grip dots on base
- Supports tablet at approximately 20° angle
- Reinforced construction

## How to Use

### Requirements
- [OpenSCAD](https://openscad.org/) (free, open-source 3D modeling software)
- 3D printer or access to 3D printing service
- Slicing software (e.g., Cura, PrusaSlicer)

### Step 1: Generate STL Files

1. Install OpenSCAD from https://openscad.org/
2. Open each .scad file in OpenSCAD
3. Click "Render" (F6) to generate the 3D model
4. Click "Export" → "Export as STL" (F7)
5. Save the STL file

Repeat for all components you want to print.

### Step 2: Prepare for Printing

1. Open the STL file in your slicing software
2. Recommended print settings:
   - **Layer Height**: 0.2mm (0.1mm for finer detail)
   - **Infill**: 20-30%
   - **Wall Thickness**: 2-3 perimeters
   - **Support**: May be needed for mounting brackets
   - **Adhesion**: Use a brim for larger parts
   - **Material**: PLA, PETG, or ABS

### Step 3: Print Parts

Print the following components:
- 1× Bottom Case
- 1× Top Case  
- 4× Mounting Brackets (included in one file)
- 1× Stand (optional)

**Estimated print times** (at 0.2mm layer height, 60mm/s):
- Bottom Case: ~4-6 hours
- Top Case: ~6-8 hours
- Mounting Brackets: ~2-3 hours
- Stand: ~3-4 hours

## Assembly

### Required Hardware

- **M2.5 screws** (8-12mm length) - for mounting Raspberry Pi and display
- **M3 screws** (16-20mm length) - for hinge assembly (4 pieces)
- **M3 nuts** - for securing hinges (4 pieces)
- Small Phillips head screwdriver

### Assembly Steps

1. **Install Raspberry Pi 5**
   - Place Raspberry Pi 5 into bottom case
   - Align mounting holes with posts
   - Secure with M2.5 screws (4 screws)

2. **Install Display**
   - Place Touch Display 2 into top case
   - Screen should be visible through front cutout
   - Secure with M2.5 screws (4 screws)
   - Route display cable through cable access hole

3. **Connect Cases**
   - Attach mounting brackets to both cases
   - Use M3 screws and nuts for hinges
   - Ensure smooth rotation of hinge joint
   - Connect display cable to Raspberry Pi

4. **Final Assembly**
   - Adjust angle as desired
   - Place on stand if using
   - Connect power and peripherals

## Customization

All .scad files are parametric and can be easily modified:

- **Adjust dimensions**: Change variables at the top of each file
- **Modify port cutouts**: Edit the difference() blocks for different positions
- **Change wall thickness**: Adjust `wall_thickness` variable
- **Add features**: OpenSCAD modules can be extended

Example customization (in OpenSCAD):
```scad
// Change wall thickness
wall_thickness = 3.0; // Default is 2.5

// Adjust tolerances
case_tolerance = 0.3; // Default is 0.5
```

## Troubleshooting

**Parts don't fit together**
- Check printer calibration
- Adjust `case_tolerance` variable in .scad files
- Scale parts by 100.5% in slicer if too tight

**Raspberry Pi doesn't fit**
- Verify you have a Raspberry Pi 5 (not Pi 4 or earlier)
- Check mounting post alignment
- File down posts if needed

**Display doesn't fit**
- Confirm you have the official Raspberry Pi Touch Display 2
- Check screen cutout dimensions
- Adjust `display_tolerance` if needed

**Weak parts**
- Increase infill percentage (30-40%)
- Add more wall perimeters (3-4)
- Use stronger material (PETG or ABS)

## Contributing

Feel free to modify and improve these designs! If you make improvements:
- Fork the repository
- Make your changes
- Submit a pull request

## License

These 3D models are provided as-is for personal and educational use. Feel free to modify and share.

## Credits

Designed for the Raspberry Pi 5 and Raspberry Pi Touch Display 2.

Raspberry Pi is a trademark of Raspberry Pi Ltd.
