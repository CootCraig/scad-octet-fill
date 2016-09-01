use <common-functions.scad>;
use <../octet-edge-fill.scad>;

coot_octet_edge_fill( fill_octahedron_edge_length = inch(20), 
                      fill_cube_width = inch(30), 
                      fill_cube_height = inch(30), 
                      fill_cube_depth = inch(30),
                      fill_edge_radius = inch(1.0),
                      fill_edge_shrink = 0.8);

