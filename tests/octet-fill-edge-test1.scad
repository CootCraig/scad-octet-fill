use <common-functions.scad>;
use <../octet-edge-fill.scad>;

coot_octet_edge_fill( fill_octahedron_step = inch(55), 
                      fill_cube_width = inch(50), 
                      fill_cube_height = inch(50), 
                      fill_cube_depth = inch(50),
                      fill_edge_radius = inch(1.0),
                      fill_edge_shrink = 0.8);

