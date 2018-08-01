

Frame myFrame = null;

void setup() {
  size(800, 800);  
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());

    ArrayList<GraphVertex> verts = new ArrayList<GraphVertex>();
    ArrayList<GraphEdge>   edges = new ArrayList<GraphEdge>();


    // TODO: PUT CODE IN TO LOAD THE GRAPH    
    JSONObject json = loadJSONObject(selection.getAbsolutePath());
    
    
    JSONArray nodes = json.getJSONArray("nodes");
      for(int i=0;i<nodes.size();i++){
        JSONObject temp = nodes.getJSONObject(i);
        verts.add(new GraphVertex(temp.getString("id"),temp.getInt("group"),random(200,width-200),random(200,height-200)));
      }
    
    JSONArray links = json.getJSONArray("links");
      for(int i=0;i<links.size();i++){
        JSONObject temp = links.getJSONObject(i);
       for(GraphVertex gv: verts){
       if(gv.getID().equals(temp.getString("source"))){
         for(GraphVertex gv2: verts){
           if(gv2.getID().equals(temp.getString("target"))){
             edges.add(new GraphEdge(gv,gv2,temp.getInt("value")));
           }
         }
         
       }
      }
      }
     
    myFrame = new ForceDirectedLayout( verts, edges );
  }
}


void draw() {
  background( 255 );

  if ( myFrame != null ) {
    myFrame.setPosition( 0, 0, width, height );
    myFrame.draw();
  }
}

void mousePressed() {
  myFrame.mousePressed();
}
void mouseDragged(){
  myFrame.mouseDragged();
}

void mouseReleased() {
  myFrame.mouseReleased();
}

abstract class Frame {

  int u0, v0, w, h;
  int clickBuffer = 2;
  void setPosition( int u0, int v0, int w, int h ) {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }

  abstract void draw();
  
  void mousePressed() { }
  void mouseReleased() { }
  void mouseDragged(){}
  
  boolean mouseInside() {
    return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY;
  }
  
}