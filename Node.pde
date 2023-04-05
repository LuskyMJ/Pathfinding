class Node {
  int key;
  PVector position;
  ArrayList<Path> neighbours = new ArrayList<Path>();
  
  color nodeColor = #4269f5;
  
  Node(int key, int x, int y) {
    this.position = new PVector(x, y);
    this.key = key;
  }
  
  void show() {
    
    // Node
    if ( ui.selectedNode == this ) {
      stroke(255, 255, 0);
      strokeWeight(5);
    }
    else noStroke();
    fill(nodeColor);
    circle(position.x, position.y, width / 20);
    
    // Text
    textSize( 20 );
    fill( 255 );
    text(str(key), position.x, position.y);
  }
  
  boolean hasNeighbour( Node otherNode ) {
    for (int i = 0; i < neighbours.size(); i++) {
      if ( (neighbours.get( i ).first == otherNode) || (neighbours.get(i).second == otherNode) ) return true;
    }
    
    return false;
  }
}
