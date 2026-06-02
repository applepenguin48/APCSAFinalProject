Board board;

void setup() {
  size(600, 600); 
  board = new Board(8, 8); 
}

void draw() {
  background(35, 35, 45);
  board.updateAnimations();
  board.display(); 

  fill(255);
  textSize(24);
  textAlign(LEFT, TOP);
  text("Score: " + board.score, 10, 10);
}

void mousePressed() {
  board.handleMouseClick(mouseX, mouseY);
}
