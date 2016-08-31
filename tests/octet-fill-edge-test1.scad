use <common-functions.scad>;
use <../octet-edge-fill.scad>;

coot_octet_edge_fill( fill_octahedron_step = inch(8), 
                      fill_cube_width = inch(20), 
                      fill_cube_height = inch(20), 
                      fill_cube_depth = inch(20),
                      fill_edge_shrink = 0.8);

