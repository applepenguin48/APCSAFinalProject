Board board;
int score = 0;

void setup() {
  size(600, 600); 
  board = new Board(8, 8); 
}

void draw() {
  background(240);
  board.display(); 
}

void mousePressed() {
  board.handleMouseClick(mouseX, mouseY);
}
