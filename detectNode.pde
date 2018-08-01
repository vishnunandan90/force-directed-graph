void detectNode(int mx,int my, ArrayList<GraphVertex> verts ){
  int buffer = 15;
  for(GraphVertex gv: verts){
    if(gv.pos.x-buffer <mx && gv.pos.x + buffer > mx && gv.pos.y-buffer > my && gv.pos.y+buffer <my ){
      println("hi");
    }
  
  }
  















}