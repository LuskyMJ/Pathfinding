class Path {
  Node first, second;
  float weight;
  color lineColor = #4287f5;
  color selectedLineColor = #00ff00;
  
  Path(Node first, Node second, float weight) {
    this.first = first;
    this.second = second;
    this.weight = weight;
  }
  
  void show() {
    stroke( lineColor );
    
    for (Path path : selectedPath) {
      if (path == this) stroke( selectedLineColor );
    }
    
    strokeWeight(10);
    textSize(20);
    line(first.position.x, first.position.y, second.position.x, second.position.y);
    
    if ( ui.showWeights ) {
      fill( 255 );
      PVector weightPosition = first.position.copy().add(second.position.copy().sub(first.position).mult(0.5f));
      text(weight, weightPosition.x, weightPosition.y);
    }
  }
  
  String toString() {
    return first.key + ":" + second.key;
  }
}
