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
main_body_width_y = 128;

main_body_depth_x = 37;

// Distance from the short edge of the cover to the first hole edge.
left_hole_edge_distance_y = 15;

// Distance from the long edge (bottom) to the left hole edge.
left_hole_edge_distance_x = 7;

// Distance between each peg hole from edge to edge
peg_hole_distance_y = 51.6;

// Overall thickness of the battery terminal cover. 
cover_thickness = 2;

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
// Creates the terminal cover body.
//
module cover_body() {

  difference() {
    // , anchor=[-1,-1,0] = positive coordinates.
    cuboid(size=[main_body_depth_x, main_body_width_y, cover_thickness]);

    // Position the left hole from the edge.
    y_pos_left = -(main_body_width_y / 2) + (peg_hole_diameter / 2) + left_hole_edge_distance_y;
    translate([0, y_pos_left, 0])
      cyl(d=peg_hole_diameter, l=cover_thickness + tol);

    // Position the right hole on the same x position, but separated in the y direction as specified.
    y_pos_right = y_pos_left + peg_hole_distance_y + (peg_hole_diameter);
    translate([0, y_pos_right, 0])
      cyl(d=peg_hole_diameter, l=cover_thickness + tol);

  }
}

//
// Builds the model.
//
module build_model() {
  cover_body();
}
build_model();
