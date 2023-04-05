Node node;
Node node2;
ArrayList<Node> checkedNodes = new ArrayList<Node>();
ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Path> paths = new ArrayList<Path>();
ArrayList<Warning> warnings = new ArrayList<Warning>();
UI ui = new UI();

void setup() {
  fullScreen();
  textAlign(CENTER, CENTER);
}

void draw() {
  background(180);
  
  for (int i = 0; i < paths.size(); i++) {
    paths.get(i).show();
  }
 
  for (int i = 0; i < nodes.size(); i++) {
    nodes.get(i).show();
  }
  
  ui.show();
 
  for (int i = 0; i < warnings.size(); i++) {
    if ( warnings.get(i).done ) warnings.remove( i );
    else warnings.get(i).show();
  }
}

void keyPressed() {
  int number = ( int )key - 49;
  
  if ( !ui.selectingWeight && number >= 0 && number <= 2 ) {
    ui.currentTool = number;
  }
  
  if (keyCode == 87 && !ui.selectingWeight) ui.showWeights = !ui.showWeights;
  
  if (keyCode == 76) loadData();
  if (keyCode == 83) saveData();
  
  ui.keyPressed( (int)key );
  
  //println(keyCode);
}

void mouseClicked() {
  ui.mouseClicked();
}

boolean isChecked(Node node) {
  for (int i = 0; i < checkedNodes.size(); i++) {
    if (checkedNodes.get(i) == node) return true;
  }
  
  return false;
}

int nearNode() {
  for (int i = 0; i < nodes.size(); i ++) {
    if ( new PVector( mouseX, mouseY ).dist( nodes.get(i).position.copy() ) <= width / 30 ) return i;
  }
  
  return -1;
}

void loadData() {
  nodes.clear();
  paths.clear();
  String[] strings = loadStrings("data.txt");
  int nodeAmount = int(split(strings[0], " ")[0]);
  int pathAmount = int(split(strings[0], " ")[1]);
  
  // Nodes
  for (int i = 0; i < nodeAmount; i++) {
    String[] node = split( strings[i + 1], " " );
    nodes.add( new Node(int(node[0]), int(float(node[1]) * width), int(float(node[2]) * height)) );
  }
  
  // Paths
  for (int i = 0; i < pathAmount; i++) {
    String[] path = split( strings[nodeAmount + 1 + i], " ");
    paths.add( new Path(nodes.get(int(path[0]) - 1), nodes.get(int(path[1]) - 1), float(path[2])) );
    nodes.get( int(path[0]) - 1 ).neighbours.add( paths.get(paths.size() - 1) );
    nodes.get( int(path[1]) - 1 ).neighbours.add( paths.get(paths.size() - 1) );
  }
  
  ui.selectedNode = nodes.get( int(strings[nodeAmount + pathAmount + 1]) -1 );
}


void saveData() {
  String[] strings = new String[nodes.size() + paths.size() + 2];
  
  // Nodes
  strings[0] = str(nodes.size()) + " " + str(paths.size());
  for (int i = 0; i < nodes.size(); i++) {
    Node current = nodes.get(i);
    strings[i + 1] = join(new String[] { str(current.key), str(current.position.x / width), str(current.position.y / height) }, " ");
  }
  
  // Paths
  for (int i = 0; i < paths.size(); i++) {
    Path current = paths.get( i );
    String path = join( new String[] { str( current.first.key ), str( current.second.key ), str( current.weight ) }, " " );
    strings[nodes.size() + 1 + i] = path;
  }
  
  strings[nodes.size() + paths.size() + 1] = str( ui.selectedNode.key );
  saveStrings("data.txt", strings);
}

// TBM
// No selected node if you load nodes
