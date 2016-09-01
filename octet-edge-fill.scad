// Author: Craig Anderson
// craig@coot.net

use <common-functions.scad>;

// Module parameters
coot_octet_fill_octahedron_circumscribe_diameter = inch(1.0);
coot_octet_fill_cube_width = inch(10);
coot_octet_fill_cube_height = inch(10);
coot_octet_fill_cube_depth = inch(10);
coot_octet_fill_edge_radius = 0.06 * coot_octet_fill_octahedron_circumscribe_diameter;
coot_octet_fill_edge_shrink = 0.75;
coot_octet_fill_oct_edge_color = color_1();
coot_octet_fill_tet_edge_color = color_2();

// See https://en.wikipedia.org/wiki/Octahedron
// ru = (a / 2) * sqrt(2)
// ru is radius of circumscribed sphere
// a is length of the octahedron edge
// ru = fill_octahedron_circumscribe_diameter / 2
// so 2 * ru = fill_octahedron_circumscribe_diameter = a * sqrt(2)
// so a = fill_octahedron_circumscribe_diameter / sqrt(2)

// See https://en.wikipedia.org/wiki/Tetrahedron
// vertices - Tetrahedron: (1,1,1), (1,−1,−1), (−1,1,−1), (−1,−1,1)
// ru = (sqrt(6) / 4) * a
// a = (4 / sqrt(6)) * ru
// ru is radius of circumscribed sphere
// a is length of the tetrahedron edge

module coot_octet_edge_fill( fill_octahedron_circumscribe_diameter = coot_octet_fill_octahedron_circumscribe_diameter,
                             fill_cube_width = coot_octet_fill_cube_width,
                             fill_cube_height = coot_octet_fill_cube_height,
                             fill_cube_depth = coot_octet_fill_cube_depth,
                             fill_edge_radius = coot_octet_fill_edge_radius,
                             fill_edge_shrink = coot_octet_fill_edge_shrink,
                             fill_oct_edge_color = coot_octet_fill_oct_edge_color,
                             fill_tet_edge_color = coot_octet_fill_tet_edge_color ) {

  // fill_octahedron_circumscribe_diameter - Space fill Octahedrons are lined up <><><><><>
  octahedron_circumscribe_radius = fill_octahedron_circumscribe_diameter / 2;
  fill_edge_length = fill_octahedron_circumscribe_diameter / sqrt(2);

  octahedron_circumscribe_radius_shrunk = octahedron_circumscribe_radius * 

  octahedron_edge_position = ((fill_octahedron_circumscribe_diameter * fill_edge_shrink) / 2);


  tetrahedron_circumscribe_radius = (sqrt(6) / 4) * fill_edge_length

  octahedron_edge_position = ((fill_octahedron_circumscribe_diameter * fill_edge_shrink) / 2);

  origin_octahedron_edges = [[[0,0,octahedron_edge_position], [octahedron_edge_position,0,0]],
                            [[0,0,octahedron_edge_position], [0,octahedron_edge_position,0]],
                            [[0,0,octahedron_edge_position], [-octahedron_edge_position,0,0]],
                            [[0,0,octahedron_edge_position], [0,-octahedron_edge_position,0]],

                            [[octahedron_edge_position,0,0], [0,octahedron_edge_position,0]],
                            [[0,octahedron_edge_position,0], [-octahedron_edge_position,0,0]],
                            [[-octahedron_edge_position,0,0], [0,-octahedron_edge_position,0]],
                            [[0,-octahedron_edge_position,0], [octahedron_edge_position,0,0]],

                            [[0,0,-octahedron_edge_position], [octahedron_edge_position,0,0]],
                            [[0,0,-octahedron_edge_position], [0,octahedron_edge_position,0]],
                            [[0,0,-octahedron_edge_position], [-octahedron_edge_position,0,0]],
                            [[0,0,-octahedron_edge_position], [0,-octahedron_edge_position,0]]];

  origin_tetrahedron_axis_position = octahedron_edge_position;
  origin_tetrahedron_points = [[origin_tetrahedron_axis_position,origin_tetrahedron_axis_position,origin_tetrahedron_axis_position],
                               [origin_tetrahedron_axis_position,-origin_tetrahedron_axis_position,-origin_tetrahedron_axis_position],
                               [-origin_tetrahedron_axis_position,origin_tetrahedron_axis_position,-origin_tetrahedron_axis_position],
                               [-origin_tetrahedron_axis_position,-origin_tetrahedron_axis_position,origin_tetrahedron_axis_position]];

  origin_tetrahedron_edges = [[origin_tetrahedron_points[0], origin_tetrahedron_points[1]],
                              [origin_tetrahedron_points[0], origin_tetrahedron_points[2]],
                              [origin_tetrahedron_points[0], origin_tetrahedron_points[3]],
                              [origin_tetrahedron_points[1], origin_tetrahedron_points[2]],
                              [origin_tetrahedron_points[1], origin_tetrahedron_points[3]],
                              [origin_tetrahedron_points[2], origin_tetrahedron_points[3]]];

  module origin_octahedron() {
    for(an_edge = origin_octahedron_edges) {
      hull() {
        translate(an_edge[0]) {
          sphere(r=fill_edge_radius);
        }
        translate(an_edge[1]) {
          sphere(r=fill_edge_radius);
        }
      }
    }
  }
  module origin_tetrahedron() {
    for(an_edge = origin_tetrahedron_edges) {
      hull() {
        translate(an_edge[0]) {
          sphere(r=fill_edge_radius);
        }
        translate(an_edge[1]) {
          sphere(r=fill_edge_radius);
        }
      }
    }
  }
  module octahedron_fill() {
    for (zoffset = [-fill_octahedron_circumscribe_diameter : fill_octahedron_circumscribe_diameter : (fill_cube_depth + fill_octahedron_circumscribe_diameter)]) {
      for (yoffset = [-fill_octahedron_circumscribe_diameter : fill_octahedron_circumscribe_diameter : (fill_cube_depth + fill_octahedron_circumscribe_diameter)]) {
        for (xoffset = [-fill_octahedron_circumscribe_diameter : (2 * fill_octahedron_circumscribe_diameter) : (fill_cube_width + fill_octahedron_circumscribe_diameter)]) {
        }
      }
    }
  }
  module octahedron_line_down_x(x_translate=0, y_translate=0, z_translate=0) {
    translate([x_translate, y_translate, z_translate]) {
      for (xoffset = [-(fill_octahedron_circumscribe_diameter / 2) : fill_octahedron_circumscribe_diameter : (fill_cube_width + (fill_octahedron_circumscribe_diameter / 2))]) {
        translate([xoffset,0,0]) {
          origin_octahedron();
        }
      }
    }
  }
  module octahedron_xy_half_slice() {
    for (yoffset = [-(fill_octahedron_circumscribe_diameter / 2) : fill_octahedron_circumscribe_diameter : (fill_cube_width + fill_octahedron_circumscribe_diameter)]) {
      octahedron_line_down_x(y_translate=yoffset);
    }
  }
  module octahedron_xy_full_slice() {
    octahedron_xy_half_slice();
    translate([fill_octahedron_circumscribe_diameter/2,fill_octahedron_circumscribe_diameter/2,0]) {
      octahedron_xy_half_slice();
}
  }
  module octahedron_xy_odd_slices() {
    for (zoffset = [0 : fill_octahedron_circumscribe_diameter : fill_cube_depth + (fill_octahedron_circumscribe_diameter / 2)]) {
      translate([0,0,zoffset]) {
        octahedron_xy_full_slice();
      }
    }
  }
  module octahedron_xy_even_slices() {
    translate([(fill_octahedron_circumscribe_diameter / 2),(fill_octahedron_circumscribe_diameter / 2),0]) {
      for (zoffset = [-(fill_octahedron_circumscribe_diameter / 4) : fill_octahedron_circumscribe_diameter : fill_cube_depth + (fill_octahedron_circumscribe_diameter / 2)]) {
        translate([0,0,zoffset]) {
          octahedron_xy_full_slice();
        }
      }
    }
  }
  module octahedron_fill() {
    octahedron_xy_odd_slices();
    octahedron_xy_even_slices();
  }

  module tester2() {
    color(fill_oct_edge_color) {
      octahedron_xy_odd_slices();
    }
  }

  module tester3() {
    color(color_1()) {
      octahedron_xy_full_slice();
    }
    color(color_2()) {
      origin_tetrahedron();
    }
  }

  tester3();
}

