class UI {
  int currentTool = 0;
  Node selectedNode, sourceNode, targetNode;
  int buttonHeight = 100;
  int buttonWidth = 200;
  boolean showWeights = true;
  int textSize = 20;
  String currentWeight = "1";
  boolean selectingWeight;
  float borderRadius = 10;
  int selectedAlgorithm = 0;
  
  void show() {
    noStroke();
    
    fill(200);
    rect(0, 0, buttonWidth, buttonHeight * 5);
    rect(width - buttonWidth, height - buttonHeight * 1, buttonWidth, buttonHeight * 1);
    
    fill(100);
    if (!selectingWeight) {
      rect(0, currentTool * buttonHeight, buttonWidth, buttonHeight);
      rect(width - buttonWidth, height - selectedAlgorithm * buttonHeight - buttonHeight, buttonWidth, buttonHeight);
    }
    
    textAlign(CENTER, CENTER);
    fill(255);
    textSize( textSize );
    text("Select Node", buttonWidth * 0.5f, buttonHeight * 0 + buttonHeight * 0.5f);
    text("Create Path", buttonWidth * 0.5f, buttonHeight * 1 + buttonHeight * 0.5f);
    text("Create Node", buttonWidth * 0.5f, buttonHeight * 2 + buttonHeight * 0.5f);
    text("Select Source Node", buttonWidth * 0.5f, buttonHeight * 3 + buttonHeight * 0.5f);
    text("Select Target Node", buttonWidth * 0.5f, buttonHeight * 4 + buttonHeight * 0.5f);
    
    text("Dijkastra Source-Target", width - buttonWidth * 0.5f, height - buttonHeight * 0 - buttonHeight * 0.5f);
    
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
    
    if (mouseX < width - buttonWidth) {
      int nearestNode = nearNode();
      if (nearestNode != -1 && !selectingWeight) {
        if ( currentTool == 0 ) selectedNode = nodes.get( nearestNode );
        
        else if ( currentTool == 1 && nodes.get( nearestNode ) != selectedNode ) {
          
          // WARNING: CHECK WHETHER THERE IS NO SELECTED NODE
          if ( !selectedNode.hasNeighbour(nodes.get(nearestNode)) ) {    
            if ( ui.showWeights ) selectingWeight = true;
            paths.add( new Path(selectedNode, nodes.get( nearestNode ), 1f) );
            selectedNode.neighbours.add( paths.get(paths.size() - 1) );
            nodes.get( nearestNode ).neighbours.add( paths.get(paths.size() - 1) );
          }
        }
        
        else if ( currentTool == 3 ) sourceNode = nodes.get( nearestNode );
        else if ( currentTool == 4 ) targetNode = nodes.get( nearestNode );
      }
      
      else if ( currentTool == 2 && mouseX >= buttonWidth && mouseX <= width - buttonWidth) {
        nodes.add( new Node( nodes.size() + 1, mouseX, mouseY) );
        if ( nodes.size() == 1 ) this.selectedNode = nodes.get( 0 );
      }
    }
    
    else {
      selectedAlgorithm = floor( (height - mouseY) / buttonHeight );
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
