// Author: Craig Anderson
// craig@coot.net

use <common-functions.scad>;

// Module parameters
coot_octet_fill_octahedron_step = inch(1.0);
coot_octet_fill_cube_width = inch(10);
coot_octet_fill_cube_height = inch(10);
coot_octet_fill_cube_depth = inch(10);
coot_octet_fill_edge_radius = 0.06 * coot_octet_fill_octahedron_step;
coot_octet_fill_edge_shrink = 0.85;
coot_octet_fill_oct_edge_color = color_1();
coot_octet_fill_tet_edge_color = color_2();


module coot_octet_edge_fill( fill_octahedron_step = coot_octet_fill_octahedron_step,
                             fill_cube_width = coot_octet_fill_cube_width,
                             fill_cube_height = coot_octet_fill_cube_height,
                             fill_cube_depth = coot_octet_fill_cube_depth,
                             fill_edge_radius = coot_octet_fill_edge_radius,
                             fill_edge_shrink = coot_octet_fill_edge_shrink,
                             fill_oct_edge_color = coot_octet_fill_oct_edge_color,
                             fill_tet_edge_color = coot_octet_fill_tet_edge_color ) {

  octahedron_edge_position = ((fill_octahedron_step * fill_edge_shrink) / 2);

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

  module origin_octahedron() {
    color( fill_oct_edge_color ) {
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
  }
  module octahedron_fill() {
    for (zoffset = [-fill_octahedron_step : fill_octahedron_step : (fill_cube_depth + fill_octahedron_step)]) {
      for (yoffset = [-fill_octahedron_step : fill_octahedron_step : (fill_cube_depth + fill_octahedron_step)]) {
        for (xoffset = [-fill_octahedron_step : (2 * fill_octahedron_step) : (fill_cube_width + fill_octahedron_step)]) {
        }
      }
    }
  }
  module tester() {
      for (yoffset = [-fill_octahedron_step : fill_octahedron_step : (fill_cube_depth + fill_octahedron_step)]) {
        for (xoffset = [-fill_octahedron_step : fill_octahedron_step : (fill_cube_width + fill_octahedron_step)]) {
          translate([xoffset,yoffset,0]) {
            origin_octahedron();
          }
        }
      }
  }

  tester();
}

