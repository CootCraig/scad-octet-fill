use <common-functions.scad>;

edges = [[[0,0,0.9], [0.9,0,0]],
         [[0,0,0.9], [0,0.9,0]],
         [[0,0,0.9], [-0.9,0,0]],
         [[0,0,0.9], [0,-0.9,0]],

         [[0.9,0,0], [0,0.9,0]],
         [[0,0.9,0], [-0.9,0,0]],
         [[-0.9,0,0], [0,-0.9,0]],
         [[0,-0.9,0], [0.9,0,0]],

         [[0,0,-0.9], [0.9,0,0]],
         [[0,0,-0.9], [0,0.9,0]],
         [[0,0,-0.9], [-0.9,0,0]],
         [[0,0,-0.9], [0,-0.9,0]]];

vertex_radius = 0.06;

module unit_oct_edges() {
  color( color_1 ) {
    for(an_edge = edges) {
      hull() {
        translate(an_edge[0]) {
          sphere(r=vertex_radius);
        }
        translate(an_edge[1]) {
          sphere(r=vertex_radius);
        }
      }
    }
  }
}
module oct_edges_layer() {
  for(yoffset=[0:2:(2*5)+2]) {
    for(xoffset = [-1:2:(2*5 + 1)]) {
      translate([xoffset,yoffset,0]) {
        unit_oct_edges();
      }
    }
  }
}

oct_edges_layer();

