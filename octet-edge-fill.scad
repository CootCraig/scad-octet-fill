// Author: Craig Anderson
// craig@coot.net

use <common-functions.scad>;

// Module parameters
coot_octet_fill_octahedron_edge_length = inch(3);
coot_octet_fill_cube_width = inch(8);
coot_octet_fill_cube_height = inch(8);
coot_octet_fill_cube_depth = inch(8);
coot_octet_fill_edge_radius = 0.06 * coot_octet_fill_octahedron_edge_length;
coot_octet_fill_edge_shrink = 0.75;
coot_octet_fill_oct_edge_color = color_1();
coot_octet_fill_tet_edge_color = color_2();

// See https://en.wikipedia.org/wiki/Octahedron
// ru = (a / 2) * sqrt(2)
// ru is radius of circumscribed sphere
// a is length of the octahedron edge
// ru = fill_octahedron_edge_length / 2
// so 2 * ru = fill_octahedron_edge_length = a * sqrt(2)
// so a = fill_octahedron_edge_length / sqrt(2)

// See https://en.wikipedia.org/wiki/Tetrahedron
// vertices - Tetrahedron: (1,1,1), (1,−1,−1), (−1,1,−1), (−1,−1,1)
// ru = (sqrt(6) / 4) * a
// a = (4 / sqrt(6)) * ru
// ru is radius of circumscribed sphere
// a is length of the tetrahedron edge

module coot_octet_edge_fill( fill_octahedron_edge_length = coot_octet_fill_octahedron_edge_length,
                             fill_cube_width = coot_octet_fill_cube_width,
                             fill_cube_height = coot_octet_fill_cube_height,
                             fill_cube_depth = coot_octet_fill_cube_depth,
                             fill_edge_radius = coot_octet_fill_edge_radius,
                             fill_edge_shrink = coot_octet_fill_edge_shrink,
                             fill_oct_edge_color = coot_octet_fill_oct_edge_color,
                             fill_tet_edge_color = coot_octet_fill_tet_edge_color ) {

  fill_octahedron_edge_length_half = fill_octahedron_edge_length / 2;
  octahedron_circumscribe_radius = fill_octahedron_edge_length_half * sqrt(2);
  tetrahedron_circumscribe_radius = (fill_octahedron_edge_length * sqrt(6)) / 4;

  origin_octahedron_vertices = [[0,0,octahedron_circumscribe_radius],
                                [fill_octahedron_edge_length_half,fill_octahedron_edge_length_half,0],
                                [fill_octahedron_edge_length_half,-fill_octahedron_edge_length_half,0],
                                [-fill_octahedron_edge_length_half,-fill_octahedron_edge_length_half,0],
                                [-fill_octahedron_edge_length_half,fill_octahedron_edge_length_half,0],
                                [0,0,-octahedron_circumscribe_radius]];

  origin_octahedron_edges = [[origin_octahedron_vertices[0], origin_octahedron_vertices[1]],
                             [origin_octahedron_vertices[0], origin_octahedron_vertices[2]],
                             [origin_octahedron_vertices[0], origin_octahedron_vertices[3]],
                             [origin_octahedron_vertices[0], origin_octahedron_vertices[4]],
                             [origin_octahedron_vertices[1], origin_octahedron_vertices[2]],
                             [origin_octahedron_vertices[2], origin_octahedron_vertices[3]],
                             [origin_octahedron_vertices[3], origin_octahedron_vertices[4]],
                             [origin_octahedron_vertices[4], origin_octahedron_vertices[1]],
                             [origin_octahedron_vertices[5], origin_octahedron_vertices[1]],
                             [origin_octahedron_vertices[5], origin_octahedron_vertices[2]],
                             [origin_octahedron_vertices[5], origin_octahedron_vertices[3]],
                             [origin_octahedron_vertices[5], origin_octahedron_vertices[4]]];

  origin_octahedron_face_indices = [[0,1,2],
                                    [0,2,3],
                                    [0,3,4],
                                    [0,4,1],
                                    [5,2,1],
                                    [5,3,2],
                                    [5,4,3],
                                    [5,1,4]];

  origin_octahedron_faces = [[origin_octahedron_vertices[0], origin_octahedron_vertices[1],origin_octahedron_vertices[2]],
                             [origin_octahedron_vertices[0], origin_octahedron_vertices[2],origin_octahedron_vertices[3]],
                             [origin_octahedron_vertices[0], origin_octahedron_vertices[3],origin_octahedron_vertices[4]],
                             [origin_octahedron_vertices[0], origin_octahedron_vertices[4],origin_octahedron_vertices[1]],
                             [origin_octahedron_vertices[5], origin_octahedron_vertices[2],origin_octahedron_vertices[1]],
                             [origin_octahedron_vertices[5], origin_octahedron_vertices[3],origin_octahedron_vertices[2]],
                             [origin_octahedron_vertices[5], origin_octahedron_vertices[4],origin_octahedron_vertices[3]],
                             [origin_octahedron_vertices[5], origin_octahedron_vertices[1],origin_octahedron_vertices[4]]];

  tetrahedron_edge_to_edge_distance = fill_octahedron_edge_length / sqrt(2);
  tetrahedron_edge_to_edge_distance_half = tetrahedron_edge_to_edge_distance / 2;

  tetrahetron_0_vertices = [[fill_octahedron_edge_length_half,0,tetrahedron_edge_to_edge_distance_half],
                                    [-fill_octahedron_edge_length_half,0,tetrahedron_edge_to_edge_distance_half],
                                    [0,fill_octahedron_edge_length_half,-tetrahedron_edge_to_edge_distance_half],
                                    [0,-fill_octahedron_edge_length_half,-tetrahedron_edge_to_edge_distance_half]];
  tetrahedron_0_face_indices = [[0,3,1],[0,1,2],[0,2,3],[1,3,2]];

  tetrahedron_1_vertices = [[0,fill_octahedron_edge_length_half,tetrahedron_edge_to_edge_distance_half],
                                     [0,-fill_octahedron_edge_length_half,tetrahedron_edge_to_edge_distance_half],
                                     [fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half],
                                     [-fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]];
  tetrahedron_1_face_indices = [[0,1,3],[0,2,1],[0,3,2],[1,2,3]];

  module origin_octahedron_edges(face_color=color_1()) {
    color( face_color ) {
      for( an_edge=origin_octahedron_edges ) {
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
  module origin_octahedron_polyhedron(face_color=color_1()) {
    color( face_color ) {
      polyhedron( points = origin_octahedron_vertices, faces = origin_octahedron_face_indices );
    }
  }
  module tetrahedron_1_polyhedron(face_color=color_3()) {
    color( face_color ) {
      polyhedron( points = tetrahedron_1_vertices, faces = tetrahedron_1_face_indices );
    }
  }
  module tetrahedron_0_polyhedron(face_color=color_3()) {
    color( face_color ) {
      polyhedron( points = tetrahetron_0_vertices, faces = tetrahedron_0_face_indices );
    }
  }
  module origin_xy_layer_0_oct_edge_test() {
    origin_point = [0,0];
    xlimit = floor(fill_cube_width / fill_octahedron_edge_length) + 1;
    ylimit = floor(fill_cube_height / fill_octahedron_edge_length) + 1;

    for(yindex = [0 : 1 : ylimit]) {
      for(xindex = [0 : 1 : xlimit]) {
        translate([(origin_point[0] + (xindex * fill_octahedron_edge_length)),
                   (origin_point[1] + (yindex * fill_octahedron_edge_length)),
                   0]) {
          origin_octahedron_edges();
        }
      }
    }
  }
  module origin_xy_layer_0_oct_test() {
    origin_point = [0,0];
    xlimit = floor(fill_cube_width / fill_octahedron_edge_length) + 1;
    ylimit = floor(fill_cube_height / fill_octahedron_edge_length) + 1;

    for(yindex = [0 : 1 : ylimit]) {
      for(xindex = [0 : 1 : xlimit]) {
        translate([(origin_point[0] + (xindex * fill_octahedron_edge_length)),
                   (origin_point[1] + (yindex * fill_octahedron_edge_length)),
                   0]) {
          origin_octahedron_polyhedron(face_color=color_1());
        }
      }
    }
  }
  module origin_xy_layer_1_oct_test() {
    origin_point = [-(fill_octahedron_edge_length / 2),-(fill_octahedron_edge_length / 2),octahedron_circumscribe_radius];
    xlimit = floor(fill_cube_width / fill_octahedron_edge_length) + 2;
    ylimit = floor(fill_cube_height / fill_octahedron_edge_length) + 2;

    for(yindex = [0 : 1 : ylimit]) {
      for(xindex = [0 : 1 : xlimit]) {
        translate([(origin_point[0] + (xindex * fill_octahedron_edge_length)),
                   (origin_point[1] + (yindex * fill_octahedron_edge_length)),
                   origin_point[2]]) {
          origin_octahedron_polyhedron(face_color=color_2());
        }
      }
    }
  }
  origin_xy_layer_0_oct_edge_test();

  translate([-fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
    tetrahedron_1_polyhedron();
  }
  translate([fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
    tetrahedron_1_polyhedron();
  }
  translate([3*fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
    tetrahedron_1_polyhedron();
  }
  translate([5*fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
    tetrahedron_1_polyhedron();
  }
  translate([0,fill_octahedron_edge_length,0]) {
    translate([-fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
      tetrahedron_1_polyhedron();
    }
    translate([fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
      tetrahedron_1_polyhedron();
    }
    translate([3*fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
      tetrahedron_1_polyhedron();
    }
    translate([5*fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
      tetrahedron_1_polyhedron();
    }
  }
  translate([0,2*fill_octahedron_edge_length,0]) {
    translate([-fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
      tetrahedron_1_polyhedron();
    }
    translate([fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
      tetrahedron_1_polyhedron();
    }
    translate([3*fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
      tetrahedron_1_polyhedron();
    }
    translate([5*fill_octahedron_edge_length_half,0,-tetrahedron_edge_to_edge_distance_half]) {
      tetrahedron_1_polyhedron();
    }
  }
}

