// most modification should occur in this file


class ForceDirectedLayout extends Frame {


  float RESTING_LENGTH = 10.0f;   // update this value
  float SPRING_SCALE   = 0.0099f; // update this value
  float REPULSE_SCALE  = 400.0f;  // update this value

  float TIME_STEP      = 0.5f;    // probably don't need to update this

  // Storage for the graph
  ArrayList<GraphVertex> verts;
  ArrayList<GraphEdge> edges;
  
  
  // Storage for the node selected using the mouse (you 
  // will need to set this variable and use it) 
  GraphVertex selected = null;
  boolean flag = false;
  
  int diffx =0;
  int diffy=0;


  ForceDirectedLayout( ArrayList<GraphVertex> _verts, ArrayList<GraphEdge> _edges ) {
    verts = _verts;
    edges = _edges;
  }

  void applyRepulsiveForce( GraphVertex v0, GraphVertex v1 ) {
    // TODO: PUT CODE IN HERE TO CALCULATE (AND APPLY) A REPULSIVE FORCE
  //finding the distance between the two points
  float d = dist(v0.pos.x,v0.pos.y,v1.pos.x,v1.pos.y);
  //finding x and y components of repulsive force
  
  float rfx = REPULSE_SCALE * v0.mass * v1.mass / (d * d) * ((v0.pos.x - v1.pos.x)/d);
  float rfy = REPULSE_SCALE *  v0.mass * v1.mass / (d * d) * ((v0.pos.y-v1.pos.y)/d);
  //adding the forces using the given methods
  v0.addForce(rfx,rfy);
  v1.addForce(-rfx,-rfy);
  
}

  void applySpringForce( GraphEdge edge ) {
    // TODO: PUT CODE IN HERE TO CALCULATE (AND APPLY) A SPRING FORCE
  //finding the length of edge 
  float d = dist(edge.v0.pos.x,edge.v0.pos.y,edge.v1.pos.x,edge.v1.pos.y); 
  //finding x and y compoents 
  float sfx =   SPRING_SCALE * max(d-RESTING_LENGTH,0)*  (edge.v0.pos.x - edge.v1.pos.x)/d; 
   float sfy =   SPRING_SCALE * max(d-RESTING_LENGTH,0) * (edge.v0.pos.y-edge.v1.pos.y)/d; 
   //adding the corresponding forces
   edge.v0.addForce(-sfx,-sfy);
   edge.v1.addForce(sfx,sfy);
   
  
}

  void draw() {
    update(); // don't modify this line
 for(GraphEdge e: edges){
   stroke(150);
      line(e.v0.pos.x,e.v0.pos.y,e.v1.pos.x,e.v1.pos.y);
    }
    for (GraphVertex gv : verts) {
      if(gv.group > 5)
      fill(100 * gv.group, 150, gv.group * 200);
      else{
       fill(200 * gv.group, gv.group * 100, 100);
      }
      stroke(0);
      ellipse(gv.pos.x, gv.pos.y, gv.diam, gv.diam);
      
    }
    
    for(GraphVertex gv: verts){
     if(mouseX>gv.pos.x-gv.diam/2 && mouseX < gv.pos.x+gv.diam/2 && mouseY > gv.pos.y-gv.diam/2 && mouseY < gv.pos.y+gv.diam/2){
     //load the object in to selected for further usage
     selected = gv;
     //display the corresponding node data
     fill(0);
     textSize(15);
     text("id: " + selected.id + " , group: " + selected.group,600,40 );    
     }
    
   }
   //adding text for instructions about interactions
    fill(0);
    textSize(15);
    text("hover and drag on vertices for interaction",5,20); 
    text("ForceDirectedGraph",width/2,20);
}


  void mousePressed() { 
    // TODO: ADD SOME INTERACTION CODE
    //the mouse should be on the ellipse of the node
    if(mouseX>selected.pos.x-selected.diam/2 && mouseX < selected.pos.x+selected.diam/2 && mouseY > selected.pos.y-selected.diam/2 && mouseY < selected.pos.y+selected.diam/2){
     flag = true;
     diffx = mouseX-(int)selected.pos.x;
     diffy = mouseY-(int)selected.pos.y;
    }else
    {
      flag = false;
    }  
  }
  void mouseDragged(){
  
  if(flag){
    selected.setPosition(mouseX-diffx,mouseY-diffy);
  }  

}
  
 

  void mouseReleased() {    
    // TODO: ADD SOME INTERACTION CODE
    flag = false;
    
  }



  // The following function applies forces to all of the nodes. 
  // This code does not need to be edited to complete this 
  // project (and I recommend against modifying it).
  void update() {
    for ( GraphVertex v : verts ) {
      v.clearForce();
    }

    for ( GraphVertex v0 : verts ) {
      for ( GraphVertex v1 : verts ) {
        if ( v0 != v1 ) applyRepulsiveForce( v0, v1 );
      }
    }

    for ( GraphEdge e : edges ) {
      applySpringForce( e );
    }

    for ( GraphVertex v : verts ) {
      v.updatePosition( TIME_STEP );
    }
  }
}