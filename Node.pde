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
    noStroke();
    fill(nodeColor);
    circle(position.x, position.y, width / 20);
    noFill();
    
    if ( ui.sourceNode == this ) {
      stroke(0, 255, 0);
      strokeWeight(8);
      circle(position.x, position.y, width / 20);
    }
    
    else if ( ui.targetNode == this ) {
      stroke(255, 0, 0);
      strokeWeight(8);
      circle(position.x, position.y, width / 20);
    }
    
    // If statement because it needs to run
    if ( ui.selectedNode == this ) {
      stroke(255, 255, 0);
      strokeWeight(5);
      circle(position.x, position.y, width / 20);
    }
    
    // Text
    textSize( 20 );
    fill( 255 );
    text(str(key), position.x, position.y);
  }
  
  boolean hasNeighbour( Node otherNode ) {
    for (int i = 0; i < neighbours.size(); i++) if ( (neighbours.get( i ).first == otherNode) || (neighbours.get(i).second == otherNode) ) return true;
    return false;
  }
  
  void shortestSourceTarget(Node target, ArrayList<Node> checkedNodes, ArrayList<Path> paths) {
    
    // Copying
    ArrayList<Node> checkedNodesCopy = new ArrayList<Node>();
    for (int i = 0; i < checkedNodes.size(); i++) {
      checkedNodesCopy.add(checkedNodes.get(i));
    }
    
    // WARNING THIS COULD BE INTEGRATED WITH THE LOOP ABOVE
    for (int i = 0; i < checkedNodesCopy.size(); i++) {
      if (checkedNodesCopy.get(i) == this) return;
    }
    
    checkedNodesCopy.add(this);
    
    for (int i = 0; i < neighbours.size(); i++) {
      Path path = neighbours.get(i);
      Node neighbour;
      
      if (path.first == this) neighbour = path.second;
      else neighbour = path.first;
      
      // Checking whether neighbour has already been checked
      boolean skipNeighbour = false;
      for (int j = 0; j < checkedNodesCopy.size(); j++) {
        if (checkedNodesCopy.get(j) == neighbour) skipNeighbour = true;
      }
      
      if (!skipNeighbour) {
        
        ArrayList<Path> pathsCopy = new ArrayList<Path>();
        for (int j = 0; j < paths.size(); j++) {
          pathsCopy.add(paths.get(j));
        }
        pathsCopy.add(path);
        
        if (neighbour == target) {
          
          // Converting Arraylist to array
          Path[] possiblePath = new Path[pathsCopy.size()];
          for (int j = 0; j < pathsCopy.size(); j++) {
            possiblePath[j] = pathsCopy.get(j);
          }
          
          possiblePaths.add(possiblePath);
        }
        
        // The neighbour is not the target and has not been checked. Run the function recursively for that neighbour
        else neighbour.shortestSourceTarget(target, checkedNodesCopy, pathsCopy);
      }
    }
  }
  
  String toString() {
    return str(key);
  }
}
