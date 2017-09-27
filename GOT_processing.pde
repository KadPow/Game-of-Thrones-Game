class SideJumper
{
  PImage image, attackImage;
  PVector position;
  float direction;
  PVector velocity;
  float jumpSpeed;
  float walkSpeed;
  boolean attacking = false;
  float cooldown = 10;
  boolean recovering = false;
  int attackFrame;
  int lives = 5;
  int kills = 0;
  int frameKills = 0;
}



SideJumper jonSnow;
float left;
float right;
float up;
float down;
String mode;
Boolean modeSelected = false;
float gravity = .5;
ArrayList<Button> Buttons;
float ground = 500;
ArrayList<Whitewalker> Whitewalkers;
boolean gameOver = false;
PImage Heart;
void setup()
{
  size(1200, 800);
  frameRate(60);
  noStroke();
  Heart = loadImage("Heart.png");
  Buttons = new ArrayList<Button>();
  Whitewalkers = new ArrayList<Whitewalker>();
  Buttons.add(new Button(600,400,200,100,"Whitewalker Assault",255,0,0));
  jonSnow = new SideJumper();
  jonSnow.image = loadImage("JonSnow.png");
  jonSnow.attackImage = loadImage("JonSnowAttack.png");
  jonSnow.position = new PVector(600, ground);
  jonSnow.direction = 1;
  jonSnow.velocity = new PVector(0, 0);
  jonSnow.jumpSpeed = 12;
  jonSnow.walkSpeed = 7;
}

void draw()
{
  background(210,255,255);
  if(!modeSelected) {
     for (int i = Buttons.size() - 1; i >= 0; i--) {
        Button b = Buttons.get(i);
        b.display();
     }
     textAlign(CENTER,CENTER);
     textSize(50);
     fill(0,0,0);
     text("Select a Mode: ",600,200);
  }
  if(!gameOver) {
      if(modeSelected) {
        if(mode.equals("Whitewalker Assault")) {
           updatejonSnow();
           if(frameCount%10 == 0) {
              if(log(frameCount)/log(8) > random(10)) {
                 Whitewalkers.add(new Whitewalker(int(random(2)),random(2,10)));
              }
           }
           if(Whitewalkers.size() > 0) {
              for(int i = Whitewalkers.size()-1; i>=0; i--) {
                  Whitewalker w = Whitewalkers.get(i);
                  w.update();
                  w.attack();
                  w.display();
              }
           }
          fill(0,0,0);
          textSize(20);
          text("Kills: " + jonSnow.kills,50,50);
          for(int i = 0; i < jonSnow.lives; i++) {
            image(Heart,1000+40*i,50,40,40);  
          }
        }
      }
      
  } else {
    
     fill(255,0,0);
     textSize(100);
     text("GAME OVER",600,200);
     fill(128,128,128);
     rect(600,600,100,200);
     fill(0,0,0);
     textSize(50);
     text("RIP",600,600);
     textSize(18);
     text("John Snow",600,525);
     textSize(12);
     text("He killed ",600,550);
     text(jonSnow.kills + " whitewalkers",600,565);
     fill(240,255,255);
     rect(600,725,1200,150);
  }
  
}

void updatejonSnow()
{
  if(jonSnow.attacking) {
    for(int i = Whitewalkers.size()-1; i >=0; i--) {
        Whitewalker w = Whitewalkers.get(i);
        if(jonSnow.direction == 1 && w.x > jonSnow.position.x && w.x - jonSnow.position.x < 100 && jonSnow.frameKills < 4) {
            Whitewalkers.remove(i);
            jonSnow.kills++;
            jonSnow.frameKills++;
        }
        if(jonSnow.direction == -1 && w.x < jonSnow.position.x && jonSnow.position.x - w.x < 100 && jonSnow.frameKills < 4) {
            Whitewalkers.remove(i);
            jonSnow.kills++;
            jonSnow.frameKills++;
        }
    }
     if(jonSnow.attackFrame + 10 < frameCount) {
        jonSnow.attacking = false;
        jonSnow.frameKills = 0;
     }
  } else if(jonSnow.recovering) {
     if(jonSnow.attackFrame + 20 < frameCount) {
        jonSnow.recovering = false; 
     }
  }
  // Only apply gravity if above ground (since y positive is down we use < ground)
  if (jonSnow.position.y < ground)
  {
    jonSnow.velocity.y += gravity;
  }
  else
  {
    jonSnow.velocity.y = 0; 
  }
  
  // If on the ground and "jump" keyy is pressed set my upward velocity to the jump speed!
  if (jonSnow.position.y >= ground && up != 0)
  {
    jonSnow.velocity.y = -jonSnow.jumpSpeed;
  }
  
  // Wlak left and right. See Car example for more detail.
  jonSnow.velocity.x = jonSnow.walkSpeed * (left + right);
  
  // We check the nextPosition before actually setting the position so we can
  // not move the jonSnow if he's colliding.
  PVector nextPosition = new PVector(jonSnow.position.x, jonSnow.position.y);
  nextPosition.add(jonSnow.velocity);
  
  // Check collision with edge of screen and don't move if at the edge
  float offset = 0;
  if (nextPosition.x > offset && nextPosition.x < (width - offset))
  {
    jonSnow.position.x = nextPosition.x;
  } 
  if (nextPosition.y > offset && nextPosition.y < (height - offset))
  {
    jonSnow.position.y = nextPosition.y;
  } 
  
  // See car example for more detail here.
  pushMatrix();
  
  translate(jonSnow.position.x, jonSnow.position.y);
  
  // Always scale after translate and rotate.
  // We're using jonSnow.direction because a -1 scale flips the image in that direction.
  scale(jonSnow.direction, 1);
  
  imageMode(CENTER);
  if(jonSnow.attacking) {
    image(jonSnow.attackImage,0,0);
  } else {
    image(jonSnow.image, 0, 0);
  }
  
  popMatrix();
}

void mouseClicked() {
    if(!modeSelected) {
        for(int i = Buttons.size()-1; i >= 0; i--) {
         Button b = Buttons.get(i);
         if(abs(mouseX-b.x) < b.w/2 && abs(mouseY-b.y) < b.h/2) {
            modeSelected = true;
            mode = b.txt;
         }
      }
    } else {
        if(!(jonSnow.attacking || jonSnow.recovering)) {
           jonSnow.attacking = true;
           jonSnow.attackFrame = frameCount;
        }
    }
}