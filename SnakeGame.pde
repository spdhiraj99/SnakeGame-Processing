import processing.sound.*;

//SoundFile eat;
//SoundFile death;
//SoundFile gameOver;
PFont pixelated;
boolean paused;
public int grid_size = 64;
public int score = 0;
public int lives = -1;
Snake s;
Food f;
void setup(){
  size(1920,1080);
  //fullScreen();
  //eat = new SoundFile(this,"eat.mp3");
  ////death = new SoundFile(this,"death.mp3");
  pixelated = createFont("assets/pixelated.ttf", 30);
  textFont(pixelated);
  s = new Snake(grid_size);
  f = new Food(grid_size);
  s.loadSprites();
  //s.setSize(s.getSize()+1);
  frameRate(10);
  paused = false;
}

void draw(){
  if(!paused){
  background(0);
  if(lives>0){
    fill(255);
    textSize(25);
    text("SCORE: " + score,width/2-20,grid_size);
    text("LIVES: " + lives,width-100,grid_size);
    if(s.eatFood(f)){
      s.setSize(s.getSize()+1);
      f.newFood();
      score += 1;
      //eat.play();
    }
    f.dispFood();
    s.updateSnake();
    s.drawSnake();
    if(s.isDead()){
      //score = 0;
      s = new Snake(grid_size);
      s.loadSprites();
      //s.setSize(s.getSize()+1);
      background(255,0,0);
      lives -= 1;
    }
  }else if (lives == 0){
    textSize(25);
    text("SCORE: " + score,width/2-50,grid_size);
    textSize(30);
    text("GAME OVER!!",width/2-95,height/2);
    text("PRESS  'R'  TO RESTART", width/2-120, height/2 + 50);
  }else if (lives == -1){
    textSize(30);
    text("SNAKE GAME",width/2-95,height/2 - 50);
    text("PRESS  'S'  TO START", width/2-110, height/2 + 25);
  }
  }
}

void keyPressed() {
   
    if (keyCode == UP || key == 'w' || key == 'W') {
      s.move("up");
    } else if (keyCode == DOWN || key == 's' || key == 'S') {
      s.move("down");
    } else if(keyCode == LEFT || key == 'a' || key == 'A'){
      s.move("left");
    } else if (keyCode == RIGHT || key == 'd' || key == 'D'){
      s.move("right");
    }

  if((key == 'R' || key == 'r') 
    && lives == 0){
    score = 0;
    lives = 3;
  }
  if((key == 'S' || key == 's') 
    && lives == -1){
    lives = 3;
  }
  if(key == ' '){
    paused = !paused;
  }
}

void mousePressed(){
  s.setSize(s.getSize()+1);
}
