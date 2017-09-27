class Whitewalker {
   
   float speed,x,y;
   boolean prepping = false;
   boolean attacking = false;
   int prepFrame = 0;
   int attackFrame = 0;
   PImage img = loadImage("whitewalker.png");
   PImage attackImg = loadImage("whitewalkerAttack.png");
  Whitewalker(int startLeft, float tspeed) {
    y = ground;
    if(startLeft == 1) {
      speed = tspeed;
      x = -20;
    } else {
       speed = -1*tspeed; 
       x = width + 20;
    }
  }
  
  void update() {
     
     if(prepping) {
         if(prepFrame + 5 < frameCount) {
            prepping = false;
            attacking = true;
            attackFrame = frameCount;
         }
     } else if (attacking){
        if(attackFrame + 5 < frameCount) {
           attacking = false;
        } else if(abs(x-jonSnow.position.x) < 50) {
           attacking = false;
           jonSnow.lives--;
           if(jonSnow.lives <= 0) {
              gameOver = true; 
           }
        }
     } else {
        x+= speed; 
     }
  }
  void display() {
     imageMode(CENTER);
     pushMatrix();
     if(speed > 0) {
       scale(-1,1);
     } else {
        scale(1,1); 
     }
     popMatrix();
     if(!attacking) {
       image(img,x,y,105,161);
     } else {
       image(attackImg,x,y,161,161);
     }
     if(prepping) {
        fill(255,0,0);
        rect(x,y-120,10,30);
        ellipse(x,y-90,5,5);
     }
  }
  void attack() {
     if(!prepping && !attacking && abs(x-jonSnow.position.x) < 50) {
         prepping = true;
         prepFrame = frameCount;
     }
  }
  
}