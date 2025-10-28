//
// Cover for the positive terminals of a Genesis Offroad Stock Battery Replacement Kit.
//
// MIT License
//
// Copyright (c) 2025 Ken Whitaker
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

// The Belfry OpenScad Library, v2:  https://github.com/BelfrySCAD/BOSL2
// This library must be installed in your instance of OpenScad to use this model.
include <BOSL2/std.scad>

// *** Model Parameters ***
/* [Model Parameters] */

// Diameter of the hole for the two pegs on the top of the terminal divider.
peg_hole_diameter = 7.8;

// Main Body width before cutouts
main_body_depth_y = 48;

main_body_width_x = 100;

// Notch width for the positive terminal connector in y direction.
// pos_term_notch_y = 16;

// Notch depth for the positive terminal connector in x direction.
pos_term_notch_x = 20;

// Distance from the short edge of the cover to the first hole edge.
left_hole_edge_distance_x = 8;

// Distance from the long edge (front y-) to the peg hole edges.
peg_hole_edge_distance_y = 7;

// Distance between each peg hole from edge to edge
peg_hole_distance_x = 52.7;

// Height of the stand off that the peg holes are at.  This brings the cover above the positive terminal studs.
peg_stand_off_z = 8;

// Width of the standoff.
peg_stand_off_y = 22;

// Overall thickness of the battery terminal cover. 
cover_thickness = 2;

// Length of the wire chase.
wire_chase_x = 30;

// Zip tie size 
zip_tie_size = 5;

// *** "Private" variables ***
/* [Hidden] */

// OpenSCAD System Settings - make curves smooth.
$fa = 1;
$fs = 0.4;

// Overlap tolerance for objects
tol = .01;

//
// Creates the peg holes
//
module peg_holes() {
  // Position the left hole from the edge.
  x_pos_left = -(main_body_width_x / 2) + (peg_hole_diameter / 2) + left_hole_edge_distance_x;

  y_pos = -(main_body_depth_y / 2) + (peg_hole_diameter / 2) + peg_hole_edge_distance_y;

  peg_hole_z = cover_thickness + peg_stand_off_z + tol;

  z_pos = -(peg_hole_z / 2) + (cover_thickness / 2) + tol;

  translate([x_pos_left, y_pos, z_pos])
    cyl(d=peg_hole_diameter, l=peg_hole_z);

  // Position the right hole on the same y position, but separated in the x direction as specified.
  x_pos_right = x_pos_left + peg_hole_diameter + peg_hole_distance_x;
  translate([x_pos_right, y_pos, z_pos])
    cyl(d=peg_hole_diameter, l=peg_hole_z);
}

//
// Notch for the positive terminal OEM connector.
//
module pos_term_notch() {
  pos_term_notch_y = main_body_depth_y - peg_stand_off_y;
  translate([(pos_term_notch_x / 2) - (main_body_width_x / 2), ( (main_body_depth_y / 2) - (pos_term_notch_y / 2)), 0])
    cuboid(size=[pos_term_notch_x + tol, pos_term_notch_y + tol, cover_thickness + tol]);
}

//
// Creates the terminal cover body.
//
module cover_body() {
  translate([pos_term_notch_x / 2, 0, 0])
    cuboid(size=[main_body_width_x - pos_term_notch_x, main_body_depth_y, cover_thickness], rounding=1, except=BOT);
}

// 
// Creates the peg hole standoffs that raises the body above the positive terminal studs.
//
module peg_stand_off() {
  translate([0, -(main_body_depth_y / 2) + (peg_stand_off_y / 2), -( (peg_stand_off_z / 2) ) + (cover_thickness / 2)])
    cuboid(size=[main_body_width_x, peg_stand_off_y, peg_stand_off_z], rounding=1, except=[BOT]);
}

//
// Wire chase for the exit wires with a notch for a zip tie.
//
module wire_chase() {
  chase_y = main_body_depth_y - peg_stand_off_y;
  x_pos = (pos_term_notch_x / 2) + (main_body_width_x / 2);

  difference() {
    translate([x_pos, (main_body_depth_y / 2) - (chase_y / 2), 0])
      cuboid(size=[wire_chase_x, chase_y, cover_thickness], rounding=1, except=[BOT, LEFT]);

    translate([x_pos, -cover_thickness, 0])
      cuboid(size=[zip_tie_size, cover_thickness, cover_thickness + tol]);
    
    translate([x_pos, chase_y-cover_thickness, 0])
      cuboid(size=[zip_tie_size, cover_thickness, cover_thickness + tol]);
  }
}

//
// Builds the model.
//
module build_model() {
  difference() {
    union() {
      cover_body();
      peg_stand_off();
    }

    peg_holes();
  }

  wire_chase();
}
build_model();
