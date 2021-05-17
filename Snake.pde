public class Snake{
  
  private int blocks_n;
  private int grid;
  private PVector pos;
  private PVector vel;
  
  private ArrayList<PVector> tail;
  private ArrayList<PVector> tailVel;
  
  public Snake(int grid){
    this.grid = grid;
    blocks_n = 0;
    pos = new PVector(1,1);
    vel = new PVector(0,0);
    tail = new ArrayList<PVector>();
    tailVel = new ArrayList<PVector>();
  }
  
  public int getSize(){
    return blocks_n;
  }
  
  public void setSize(int n){
    this.blocks_n = n;
  }
  
  public boolean eatFood(Food f){
    PVector foodPos = f.getLoc();
    if(pos.dist(foodPos) < grid - 1){
      return true;
    }
    return false;
  }
  
  public boolean isDead(){
    for(PVector p : tail){
      if(pos.dist(p)< grid-1){
        blocks_n = 0;
        tail = new ArrayList<PVector>();
        tailVel = new ArrayList<PVector>();
        return true;
      }
    }
    return false;
  }
  
  public void updateSnake(){
    if(blocks_n != tail.size()){
      tail.add(new PVector(pos.x,pos.y));
      tailVel.add(new PVector(vel.x,vel.y));
    }
    for(int i = blocks_n-1; i>=0; i--){
      if(i==0){
        tail.set(i,new PVector(pos.x,pos.y));
        tailVel.set(i,new PVector(vel.x,vel.y));
        continue;
      }
      tail.set(i,tail.get(i-1));
      tailVel.set(i, tailVel.get(i-1));
    }
    vel.setMag(grid);
    pos.add(vel);
    screenWarp();
  }
  
  private void screenWarp(){
    if(pos.x<0){
      pos.x = width;
    }else if(pos.x>width){
      pos.x = 0;
    }
    if(pos.y<0){
      pos.y=height;
    }else if(pos.y>height){
      pos.y = 0;
    }
  }
  
  public void move(String dir){
    switch(dir.toLowerCase()){
      case "up":
        if(vel.y<=0) vel.y = -1;
        vel.x = 0;
        break;
      case "down":
        if(vel.y>=0) vel.y = 1;
        vel.x = 0;
        break;
      case "left":
        if(vel.x<=0) vel.x = -1;
        vel.y = 0;
        break;
      case "right":
        if(vel.x>=0) vel.x = 1;
        vel.y = 0;
        break;
    }
  }
  
  public void drawSnake(){
    fill(255);
    for(int i =0; i<blocks_n; i++){
      rect(tail.get(i).x,tail.get(i).y,grid,grid);
      //if(tailVel.get(i).y!=0)
      //  ellipse(tail.get(i).x+grid/2,tail.get(i).y+grid/2, grid/2, grid);
      //else
      //  ellipse(tail.get(i).x+grid/2,tail.get(i).y+grid/2, grid, grid/2);
    }
    fill(255);
    rect(pos.x, pos.y, grid, grid);
    //if(vel.y!=0)
    //  ellipse(pos.x+grid/2,pos.y+grid/2, grid/2, grid);
    //else
    //  ellipse(pos.x+grid/2,pos.y+grid/2, grid, grid/2);
  }
}
