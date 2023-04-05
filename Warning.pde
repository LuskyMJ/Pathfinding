class Warning {
  float buttonWidth = width * 0.4f;
  float buttonHeight = buttonWidth * 0.1f;
  int textSize = 30;
  String text;
  int startTime = millis();
  int milliDur;
  boolean done = false;
  
  Warning ( String text, int milliDur ) {
    this.text = text;
    this.milliDur = milliDur;
  }
  
  void show() {
    if ( millis() - startTime >= milliDur ) done = true;
    else {
      fill(255, 0, 0);
      rect( width / 2 - buttonWidth / 2, height - buttonHeight - 10, buttonWidth, buttonHeight, buttonHeight / 10f );
      fill( 255 );
      textSize( textSize );
      text(text, width / 2, height - ui.buttonHeight / 2 - 10);
    }  
  }
}
