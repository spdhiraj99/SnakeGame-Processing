public class Food{
  
  private int grid;
  private PVector loc;
  
  public Food(int grid){
    this.grid = grid;
    newFood();
  }
  
  public PVector getLoc(){
    return loc;
  }
  
  public void newFood(){
    int col = floor(width/grid);
    int row = floor(height/grid);
    loc = new PVector(floor(random(col)), floor(random(row)));
    loc.mult(grid);
  }
  
  public void dispFood(){
    fill(255,0,0);
    //rect(loc.x,loc.y, grid, grid);
    image(s.parts[14],loc.x,loc.y);
  }
  
}
