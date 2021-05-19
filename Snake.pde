public class Snake{
  
  private int blocks_n;
  private int grid;
  private PVector pos;
  private PVector vel;
  
  /** sourabh boi**/
  PImage spriteSheet;
  PImage [] parts;
  /** sourabh boi **/
  
  private ArrayList<PVector> tail;
  private ArrayList<PVector> tailVel;
  
  public Snake(int grid){
    this.grid = grid;
    blocks_n = 0;
    pos = new PVector(1,1);
    vel = new PVector(1,0);
    tail = new ArrayList<PVector>();
    tailVel = new ArrayList<PVector>();
    /** sourabh boi**/
     parts = new PImage[16];
     /** sourabh boi **/
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
       //blocks_n = 0;
       //tail = new ArrayList<PVector>();
       //tailVel = new ArrayList<PVector>();
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
  
  /** sourabh boi **/
  void loadSprites()
  {
    int index = 0;
    spriteSheet = loadImage("assets/snake.png");
    for(int i=0;i<4;++i)
      for(int j=0;j<4;++j)
        parts[index++] = spriteSheet.get(j*grid,i*grid,grid,grid);
  }
  /** sourabh boi **/
  
  public void drawSnake(){
    fill(255);
    for(int i =0; i<blocks_n; i++){
      if(tailVel.get(i).y>0){
        //down
        if(i==0 && PVector.angleBetween(tailVel.get(i),vel) != 0){
          image(parts[10],tail.get(i).x,tail.get(i).y);
        }else if(i<blocks_n-1 && PVector.angleBetween(tailVel.get(i+1),tailVel.get(i)) != 0){
          if(tailVel.get(i+1).x > 0){
            //down right  ----- right down
            image(parts[10],tail.get(i).x,tail.get(i).y);
          } else if(tailVel.get(i+1).x < 0){
            //down left ----- left down
            image(parts[9],tail.get(i).x,tail.get(i).y);
          }
        }else if(i==blocks_n-1){
          image(parts[6],tail.get(i).x,tail.get(i).y);
        }else{
          image(parts[12],tail.get(i).x,tail.get(i).y);
        }
      }else if(tailVel.get(i).y<0){
        //up
        if(i==0 && PVector.angleBetween(tailVel.get(i),vel) != 0){
          image(parts[8],tail.get(i).x,tail.get(i).y);
        }else if(i<blocks_n-1 && PVector.angleBetween(tailVel.get(i+1),tailVel.get(i)) != 0){
          if(tailVel.get(i+1).x > 0){
            //up right --- right up
            image(parts[11],tail.get(i).x,tail.get(i).y);
          } else if(tailVel.get(i+1).x < 0){
            //up left  --- left up
            image(parts[8],tail.get(i).x,tail.get(i).y);
          }
        }else if(i==blocks_n-1){
          image(parts[4],tail.get(i).x,tail.get(i).y);
        }else{
          image(parts[12],tail.get(i).x,tail.get(i).y);
        }
      }else if(tailVel.get(i).x>0){
        //right
        if(i==0 && PVector.angleBetween(tailVel.get(i),vel) != 0){
          image(parts[9],tail.get(i).x,tail.get(i).y);          
        }else if(i<blocks_n-1 && PVector.angleBetween(tailVel.get(i+1),tailVel.get(i)) != 0){
          if(tailVel.get(i+1).y > 0){
            // from right to down --- down right
            image(parts[8],tail.get(i).x,tail.get(i).y);
          } else if(tailVel.get(i+1).y < 0){
            // from right to up  --- up right
            image(parts[9],tail.get(i).x,tail.get(i).y);
          }
        }else if(i==blocks_n-1){
          image(parts[5],tail.get(i).x,tail.get(i).y);
        }else{
          image(parts[13],tail.get(i).x,tail.get(i).y);
        }
      }else if(tailVel.get(i).x<0){
        //left
        if(i==0 && PVector.angleBetween(tailVel.get(i),vel) != 0){
          image(parts[11],tail.get(i).x,tail.get(i).y);
        }else if(i<blocks_n-1&& PVector.angleBetween(tailVel.get(i+1),tailVel.get(i)) != 0){
          if(tailVel.get(i+1).y > 0){
            // from left to down  -- down left
            image(parts[11],tail.get(i).x,tail.get(i).y);
          } else if(tailVel.get(i+1).y < 0){
            // from left to up  -- up left
            image(parts[10],tail.get(i).x,tail.get(i).y);
          }
        }else if(i==blocks_n-1){
          image(parts[7],tail.get(i).x,tail.get(i).y);
        }else{
          image(parts[13],tail.get(i).x,tail.get(i).y);
        }
      }
    }
    fill(255);
    
    if(vel.y==grid){
      //down
      image(parts[2],pos.x,pos.y);
    } else if(vel.y==-grid){
      //up
      image(parts[0],pos.x,pos.y);
    } else if(vel.x==grid){
      //right
      image(parts[1],pos.x,pos.y);
    } else if(vel.x==-grid){
      //left
      image(parts[3],pos.x,pos.y);
    }
    
  }
}
