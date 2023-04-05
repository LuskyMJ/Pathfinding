class UI {
  int currentTool = 0;
  Node selectedNode;
  int buttonHeight = 100;
  int buttonWidth = 200;
  boolean showWeights = true;
  int textSize = 20;
  String currentWeight = "1";
  boolean selectingWeight;
  float borderRadius = 10;
  
  void show() {
    noStroke();
    
    fill(200);
    rect(0, 0, buttonWidth, buttonHeight * 3);
    
    fill(100);
    if (!selectingWeight) rect(0, currentTool * buttonHeight, buttonWidth, buttonHeight);
    
    textAlign(CENTER, CENTER);
    fill(255);
    textSize( textSize );
    text("Select Node", buttonWidth * 0.5f, buttonHeight * 0 + buttonHeight * 0.5f);
    text("Create Path", buttonWidth * 0.5f, buttonHeight * 1 + buttonHeight * 0.5f);
    text("Create Node", buttonWidth * 0.5f, buttonHeight * 2 + buttonHeight * 0.5f);
    
    // Weights
    String text = "Weight: ON";
    if (showWeights) {
      text("Weight: ON", width - buttonWidth / 2, buttonHeight / 2);
      fill(0, 255, 0);
    }
    
    else {
      text = "Weight: OFF";
      fill(255, 0, 0);
    }
    
    rect(width - buttonWidth, 0, buttonWidth, buttonHeight);
    fill(255);
    text(text, width - buttonWidth / 2, buttonHeight / 2);
    
    if (selectingWeight) {
      fill(100, 150);
      rect(0, 0, width, height);
      
      fill(255);
      text("Enter weight", width / 2, height / 2 - buttonHeight);
      fill(100);
      rect(width / 2 - buttonWidth / 2, height / 2 - buttonHeight / 2, buttonWidth, buttonHeight, borderRadius);
      fill(255);
      text(currentWeight, width / 2, height / 2);

    }
  }
  
  void mouseClicked() {
    int nearestNode = nearNode();
    
    if (nearestNode != -1) {
      if ( currentTool == 0 ) {
        selectedNode = nodes.get( nearestNode );
      }
      
      if ( currentTool == 1 && nodes.get( nearestNode ) != selectedNode ) {
        
        // WARNING: CHECK WHETHER THERE IS NO SELECTED NODE
        if ( !selectedNode.hasNeighbour(nodes.get(nearestNode)) ) {    
          if ( ui.showWeights ) selectingWeight = true;
          paths.add( new Path(selectedNode, nodes.get( nearestNode ), 1f) );
          selectedNode.neighbours.add( paths.get(paths.size() - 1) );
          nodes.get( nearestNode ).neighbours.add( paths.get(paths.size() - 1) );
        }
      }
    }
    
    else if ( currentTool == 2) {
      nodes.add( new Node( nodes.size() + 1, mouseX, mouseY) );
      if ( nodes.size() == 1 ) this.selectedNode = nodes.get( 0 );
    }
  }
  
  void keyPressed(int pressed) {
    // 8 = delete
    // 10 = enter
    // 46 = dot
    int number = pressed - 48;
    
    if (selectingWeight) {
      if ( number >= 0 && number <= 9 ) {
        currentWeight += str(number);
      }
      
      else {
        if ( pressed == 10 ) {
          paths.get( paths.size() - 1 ).weight = float( currentWeight );
          currentWeight = "1";
          selectingWeight = false;
        }
        
        else if ( pressed == 8 && currentWeight.length() > 0 ) {
          currentWeight = currentWeight.substring(0, currentWeight.length() - 1);
        }
        
        else if ( pressed == 46 && currentWeight.indexOf(".") == -1) {
          currentWeight += ".";
        }
      }
    }
  }
}

// selectNode = 0
// createPath = 1
// createNode = 2
